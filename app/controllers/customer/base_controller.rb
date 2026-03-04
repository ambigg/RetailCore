class Customer::BaseController < ApplicationController
  before_action :authenticate_user!
    before_action :check_customer

  private

  def check_customer
    unless current_user.customer?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
