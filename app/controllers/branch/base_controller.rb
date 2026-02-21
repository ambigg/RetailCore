class Branch::BaseController < ApplicationController
  layout "branch"
  before_action :authenticate_user!
  before_action :verify_store_employee_role!

  private

  def verify_store_employee_role!
    redirect_to root_path, alert: "Access denied" unless current_user.store_employee? || current_user.admin?
  end
end
