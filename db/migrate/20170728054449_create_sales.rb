class CreateSales < ActiveRecord::Migration[5.1]
  def change
    create_table :sales do |t|
      t.string :nature
      t.references :debtor, foreign_key: true
      t.string :village
      t.string :phone
      t.float :total_amount

      t.timestamps
    end
  end
end
