class Inventory::BaseController < ApplicationController
  layout "inventory"
  before_action :authenticate_user!
  before_action :verify_inventory_manager_role!

  private

  def verify_inventory_manager_role!
    redirect_to root_path, alert: "Access denied" unless current_user.inventory_manager? || current_user.admin?
  end
end
