class Branch < ApplicationRecord
  validates :name, presence: true
  has_many :inventories, dependent: :destroy
  has_many :sales, dependent: :destroy

  enum :status, {
    active: 0,
    inactive: 1
  }, default: :active
end
