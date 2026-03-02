class Warehouse::OrdersController < Warehouse::BaseController
  def show
    @order = Order.includes(:customer).find(params[:id])
    @order_items = @order.order_items.includes(:product_variant)
  end
  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to warehouse_order_path(@order), notice: "Order updated successfully"
    else
      render :show, status: :unprocessable_entity
    end
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end
end
