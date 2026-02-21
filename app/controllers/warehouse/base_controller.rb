class Warehouse::BaseController < ApplicationController
  layout "warehouse"
  before_action :authenticate_user!
  before_action :check_warehouse_staff_role!

  private

  def check_warehouse_staff_role!
    redirect_to root_path, alert: "Access denied" unless current_user.warehouse_staff? || current_user.admin?
  end
end
