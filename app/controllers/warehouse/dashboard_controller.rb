class Warehouse::DashboardController < Warehouse::BaseController
  def index
    @orders = Order.includes(:customer).order(created_at: :desc).where(status: [ :processing ])
  end
end
