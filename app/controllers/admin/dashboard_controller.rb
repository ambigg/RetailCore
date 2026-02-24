class Admin::DashboardController < Admin::BaseController
  def index
    @total_users = User.count
    @product_count = Product.count
    @branch_count = Branch.count
    @recent_users = User.order(created_at: :desc).limit(5)
    @recent_products = Product.order(created_at: :desc).limit(5)
  end
end
