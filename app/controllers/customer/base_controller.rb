class Customer::BaseController < ApplicationController
  before_action :authenticate_user!
end
