class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products, dependent: :destroy

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
