class ChangeStockToIntegerInProducts < ActiveRecord::Migration[8.1]
  def change
   change_column :products, :stock, :integer
  end
end
