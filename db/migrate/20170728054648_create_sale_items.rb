class CreateSaleItems < ActiveRecord::Migration[5.1]
  def change
    create_table :sale_items do |t|
      t.references :article, foreign_key: true
      t.references :sale, foreign_key: true
      t.integer :quantity
      t.float :price
      t.float :amount

      t.timestamps
    end
  end
end
