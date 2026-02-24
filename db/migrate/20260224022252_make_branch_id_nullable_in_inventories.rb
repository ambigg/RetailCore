class MakeBranchIdNullableInInventories < ActiveRecord::Migration[8.1]
  def change
    change_column_null :inventories, :branch_id, true
  end
end
