class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.string :sku, null: false
      t.integer :minimum_stock, null: false, default: 0

      t.timestamps
    end

    add_index :products, :sku, unique: true
  end
end
