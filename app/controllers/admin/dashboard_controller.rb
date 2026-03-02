class Admin::DashboardController < Admin::BaseController
  def index
    @sales_today = Order.where(created_at: Time.current.all_day).sum(:total)
    @total_orders = Order.count
    @average_ticket = Order.average(:total)&.round(2) || 0
     @sales_last_30_days = Order.where(created_at: 30.days.ago..Time.current)
                               .group_by_day(:created_at)
                               .sum(:total)
  end
end
