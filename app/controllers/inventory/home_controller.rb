class Inventory::HomeController < Inventory::BaseController
  def index
    @products_count = current_user.products.count
  end
end
