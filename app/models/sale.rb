class Sale < ApplicationRecord
  belongs_to :branch
  belongs_to :employee, class_name: "User", foreign_key: "store_employee_id"
  has_many :sale_items, dependent: :destroy

  enum status: {
    completed: 0,
    cancelled: 1
  }

  validates :total, numericality: { greater_than_or_equal_to: 0 }
end
