class Inventory::DashboardController < Inventory::BaseController
  def index
    @products = current_user.products.includes(product_variants: :inventories)
    @total_products= @products.count
    @orders = Order.all.order(created_at: :desc)
    @total_stock = Inventory.joins(product_variant: :product)
                            .where(products: { user_id: current_user.id })
                            .sum(:quantity)

    @low_stock = ProductVariant.joins(:inventories, product: :user)
                               .where(products: { user_id: current_user.id })
                               .group("product_variants.id")
                               .having("SUM(inventories.quantity) < 10")
                               .count.size

    @pending_orders = Order.joins(order_items: { product_variant: :product })
                           .where(products: { user_id: current_user.id })
                           .where(status: "pending")
                           .distinct
                           .count
  end
end
