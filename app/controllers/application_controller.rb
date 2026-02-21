class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_root_path
    elsif resource.inventory_manager?
      inventory_root_path
    elsif resource.store_employee?
      branch_root_path
    elsif resource.warehouse_staff?
      warehouse_root_path
    else
      customer_root_path
    end
  end
  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end
end
