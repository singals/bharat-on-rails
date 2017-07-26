class CreatePurchaseItems < ActiveRecord::Migration[5.1]
  def change
    create_table :purchase_items do |t|
      t.references :article, foreign_key: true
      t.references :purchase, foreign_key: true
      t.integer :quantity
      t.float :price
      t.float :cost

      t.timestamps
    end
  end
end
