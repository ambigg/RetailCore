class Inventory::ProductsController < Inventory::BaseController
  before_action :set_product, only: [ :show, :edit, :update, :destroy ]

  def index
    @products = current_user.products
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      redirect_to inventory_product_path(@product), notice: "Product created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      redirect_to inventory_products_path, notice: "Product updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @product.destroy
    redirect_to inventory_products_path, notice: "Product deleted successfully."
  end

  private
  def set_product
    @product = current_user.products.find(params[:id])
  end

  def product_params
      params.require(:product).permit(:name, :description, :category, :active)
  end
end
