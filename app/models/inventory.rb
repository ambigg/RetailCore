class Inventory < ApplicationRecord
  belongs_to :product_variant
  belongs_to :branch, optional: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
