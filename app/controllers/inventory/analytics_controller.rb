class Inventory::AnalyticsController < Inventory::BaseController
  def index
    @orders = current_user.products.includes(:order_items)
  end
end
