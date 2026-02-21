class CreateProductVariants < ActiveRecord::Migration[8.1]
  def change
    create_table :product_variants do |t|
      t.references :product, null: false, foreign_key: true
      t.string :sku
      t.string :size
      t.string :color
      t.string :material
      t.decimal :price
      t.integer :stock, default: 0

      t.timestamps
    end
  end
end
