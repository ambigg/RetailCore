class Inventory::DashboardController < Inventory::BaseController
  def index
    @products = current_user.products.includes(product_variants: :inventories)
    @total_products= @products.count
    @orders = Order.all.order(created_at: :desc)
  end
end
