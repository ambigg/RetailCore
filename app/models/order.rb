class Order < ApplicationRecord
  belongs_to :customer, class_name: "User", foreign_key: "customer_id"
  has_many :order_items, dependent: :destroy
  enum :status, {
    pending: 0,
    paid: 1,
    processing: 2,
    shipped: 3,
    delivered: 4,
    cancelled: 5
  }, default: :pending

  after_update :handle_stock_on_shipped, if: :shipped_now?
  after_update :release_stock_on_cancelled, if: :cancelled_now?

  private

  def shipped_now?
    status_previously_changed? && status == "shipped"
  end

  def cancelled_now?
    status_previously_changed? && status == "cancelled"
  end

  def handle_stock_on_shipped
    order_items.each do |item|
      inventory = item.product_variant.inventories.find_by(branch_id: nil)
      inventory.decrement!(:quantity, item.quantity)
      inventory.decrement!(:reserved, item.quantity)
    end
  end

  def release_stock_on_cancelled
    order_items.each do |item|
      inventory = item.product_variant.inventories.find_by(branch_id: nil)
      inventory.decrement!(:reserved, item.quantity)
    end
  end
end
