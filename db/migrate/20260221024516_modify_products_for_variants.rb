class ModifyProductsForVariants < ActiveRecord::Migration[8.1]
  def change
  remove_column :products, :price, :decimal
  remove_column :products, :stock, :integer
  add_column :products, :active, :boolean, default: true
  end
end
