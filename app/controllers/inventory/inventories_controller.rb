class Inventory::InventoriesController < Inventory::BaseController
  before_action :set_product
  before_action :set_variant

  def index
    @inventories = @variant.inventories.includes(:branch)
    @branches = Branch.all
  end

  def new
    @inventory = @variant.inventories.build
  end

  def create
    @inventory = @variant.inventories.build(inventories_params)
    if @inventory.save
      redirect_to inventory_product_product_variant_inventories_path(@product, @variant), notice: "Stock added successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @inventory = @variant.inventories.find(params[:id])
  end

  def update
    @inventory = @variant.inventories.find(params[:id])
    if @inventory.update(inventories_params)
      redirect_to inventory_product_product_variant_inventories_path(@product, @variant), notice: "Stock updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = current_user.products.find(params[:product_id])
  end
  def set_variant
    @variant = @product.product_variants.find(params[:product_variant_id])
  end
  def inventories_params
    params.require(:inventory).permit(:branch_id, :quantity)
  end
end
