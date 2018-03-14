# frozen_string_literal: true

class CreateProfitAndLossAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :profit_and_loss_accounts do |t|
      t.string :description
      t.float :amount
      t.float :current_balance
      t.string :financial_year

      t.timestamps
    end
    add_index :profit_and_loss_accounts, :financial_year
  end
end
