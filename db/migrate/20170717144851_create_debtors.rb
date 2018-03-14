# frozen_string_literal: true

class CreateDebtors < ActiveRecord::Migration[5.1]
  def change
    create_table :debtors do |t|
      t.string :name
      t.string :village
      t.string :phone
      t.boolean :is_active

      t.timestamps
    end
  end
end
