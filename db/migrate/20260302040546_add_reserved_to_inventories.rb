class AddReservedToInventories < ActiveRecord::Migration[8.1]
  def change
      add_column :inventories, :reserved, :integer, default: 0
  end
end
