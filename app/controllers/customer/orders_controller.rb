class Customer::OrdersController < Customer::BaseController
  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def show
    @order = current_user.orders.find(params[:id])
    @order_items = @order.order_items.includes(:product)
  end

  def new
    @cart = Cart.new(session)
    redirect_to cart_path, alert: "Cart is empty" if @cart.items.empty?
    @items = @cart.items.map do |item|
    {
      variant: ProductVariant.find(item[:variant_id]), quantity: item[:quantity]
    }
    end
    @order = Order.new
  end

  def create
  @cart = Cart.new(session)

  @order = current_user.orders.new(
      status: :pending,
      total: @cart.total,
      shipping_address: params[:order][:shipping_address]
    )
  @cart.items.each do |item|
    variant = ProductVariant.find(item[:variant_id])
    inventory = variant.inventories.find_by(branch_id: nil)
    if inventory.nil? ||inventory.available < item[:quantity]
      redirect_to cart_path, alert: "Not enough stock for #{variant.sku}"
        return
    end
    @order.order_items.build(
      product_variant_id: item[:variant_id],
      quantity: item[:quantity],
      price: variant.price
    )
    end
  if @order.save
    @order.order_items.each do |order_item|
    inventory = Inventory.find_by(product_variant_id: order_item.product_variant_id, branch_id: nil)
    inventory.increment!(:reserved, order_item.quantity)
  end
    @cart.clear
    redirect_to customer_order_path(@order), notice: "Order placed successfully"
  else
    render :new, status: :unprocessable_entity
  end
  end
end
