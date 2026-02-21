class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.string :category
      t.decimal :stock
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
