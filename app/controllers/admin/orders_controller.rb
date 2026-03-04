class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.includes(:customer).order(created_at: :desc)
    @orders_by_status = @orders.group_by { |o| o.status.to_sym }
  end

  def show
    @order = Order.includes(:customer).find(params[:id])
    @order_items = @order.order_items.includes(:product_variant)
  end
  def update
    @order = Order.find(params[:id])
    @order.update(status: params[:status])
    redirect_to inventory_orders_path
  end
  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to admin_orders_path, notice: "Order deleted."
  end
end
