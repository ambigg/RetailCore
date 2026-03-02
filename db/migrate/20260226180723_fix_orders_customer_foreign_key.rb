class FixOrdersCustomerForeignKey < ActiveRecord::Migration[8.1]
  def change
    remove_foreign_key :orders, column: :customer_id
    add_foreign_key :orders, :users, column: :customer_id
  end
end
