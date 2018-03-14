# frozen_string_literal: true

class CreatePurchases < ActiveRecord::Migration[5.1]
  def change
    create_table :purchases do |t|
      t.string :seller_name
      t.string :city
      t.string :phone
      t.integer :invoice_number
      t.float :total_cost

      t.timestamps
    end
  end
end
