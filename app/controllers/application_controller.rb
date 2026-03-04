class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_root_path
    elsif resource.inventory_manager?
      inventory_root_path
    elsif resource.store_employee?
      branch_root_path
    elsif resource.warehouse_staff?
      warehouse_root_path
    else resource.customer?
      root_path
    end
  end
  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :phone, :address ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :phone, :address ])
  end
end
