class Inventory::ProductVariantsController < Inventory::BaseController
  before_action :set_product
  before_action :set_variant, only: [ :edit, :update, :destroy ]

  def new
    @variant = @product.product_variants.build
  end

  def create
    @variant = @product.product_variants.build(variant_params)
    if @variant.save
      redirect_to inventory_product_path(@product), notice: "Variant created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @variant.update(variant_params)
      redirect_to inventory_product_path(@product), notice: "Variant updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @variant.destroy
    redirect_to inventory_product_path(@product), notice: "Variant deleted."
  end

  private

  def set_product
    @product = current_user.products.find(params[:product_id])
  end

  def set_variant
    @variant = @product.product_variants.find(params[:id])
  end

  def variant_params
    params.require(:product_variant).permit(:sku, :size, :color, :material, :price, :stock)
  end
end
