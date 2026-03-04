class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :branch, optional: true
  has_many :products, dependent: :destroy
  has_many :orders, foreign_key: "customer_id", dependent: :destroy
  has_many :sales, foreign_key: "store_employee_id", dependent: :destroy

  enum :role, {
    admin: 0,
    customer: 1,
    warehouse_staff: 2,
    inventory_manager: 3,
    store_employee: 4
  }

  after_initialize :set_default_role, if: :new_record?


  private
  def set_default_role
    self.role ||= :customer
  end
end
