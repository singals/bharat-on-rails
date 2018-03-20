# frozen_string_literal: true

class CreateDeposits < ActiveRecord::Migration[5.1]
  def change
    create_table :deposits do |t|
      t.string :nature
      t.float :amount
      t.references :debtor, foreign_key: true

      t.timestamps
    end
  end
end
