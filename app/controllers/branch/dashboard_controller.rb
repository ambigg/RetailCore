class Branch::DashboardController < Branch::BaseController
  before_action :set_sale, only: [ :show ]

  def index
    @sales = current_user.branch.sales.order(created_at: :desc)
    @sales = filter_by_date(@sales)
  end

  def new
    @sale = current_user.branch.sales.new
    @sale.sale_items.build # un item vacío para el formulario
  end

  def create
    @sale = current_user.branch.sales.new(employee: current_user)
    process_sale_items

    if @sale.errors.any? || @sale.sale_items.empty?
      @sale.errors.add(:base, "No valid items") if @sale.sale_items.empty?
      render :new, status: :unprocessable_entity
    else
      @sale.total = calculate_total
      if @sale.save
        deduct_inventory
        redirect_to branch_sale_path(@sale), notice: "Sale recorded successfully"
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def show
  end

  private

  def set_sale
    @sale = current_user.branch.sales.find(params[:id])
  end

  def filter_by_date(sales)
    case params[:filter]
    when "today"
      sales.where("created_at >= ?", Time.current.beginning_of_day)
    when "week"
      sales.where("created_at >= ?", Time.current.beginning_of_week)
    when "month"
      sales.where("created_at >= ?", Time.current.beginning_of_month)
    else
      sales
    end
  end

  def process_sale_items
    items_params = params[:sale][:sale_items_attributes] || {}
    items_params.each do |_, item|
      variant = ProductVariant.find_by(id: item[:product_variant_id])
      quantity = item[:quantity].to_i

      next if variant.nil? || quantity <= 0

      inventory = Inventory.find_by(product_variant: variant, branch: current_user.branch)
      if inventory.nil? || inventory.quantity < quantity
        @sale.errors.add(:base, "Insufficient stock for #{variant.product.name} (#{variant.size})")
        next
      end

      @sale.sale_items.build(
        product_variant: variant,
        quantity: quantity,
        price: variant.price
      )
    end
  end

  def calculate_total
    @sale.sale_items.sum { |item| item.price * item.quantity }
  end

  def deduct_inventory
    @sale.sale_items.each do |item|
      inventory = Inventory.find_by!(
        product_variant: item.product_variant,
        branch: current_user.branch
      )
      inventory.decrement!(:quantity, item.quantity)
    end
  end
end
