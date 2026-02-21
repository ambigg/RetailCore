class Product < ApplicationRecord
  belongs_to :user
  has_many :product_variants, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
end
