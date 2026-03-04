class CreateSales < ActiveRecord::Migration[8.1]
  def change
    create_table :sales do |t|
      t.references :branch, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: { to_table: :users }
      t.decimal :total, precision: 10, scale: 2, default: 0, null: false
      t.integer :status, default: 0, null: false   # 0: completed, 1: cancelled
      t.timestamps
    end
    add_index :sales, :created_at   # útil para filtrar por fechas
  end
end
