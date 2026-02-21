class Customer::OrdersController < Customer::BaseController
  # before_action :authenticate_customer!

  def index
    # @orders = current_customer.orders.order(created_at: :desc)
  end

  def show
    # @order = current_customer.orders.find(params[:id])
    # @order_items = @order.order_items.includes(:product)
  end
end
