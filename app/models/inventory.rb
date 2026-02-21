class Inventory < ApplicationRecord
  belongs_to :product_variant
  belongs_to :branch
end
