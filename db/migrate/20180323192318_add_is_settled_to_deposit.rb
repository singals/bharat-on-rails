# frozen_string_literal: true

class AddIsSettledToDeposit < ActiveRecord::Migration[5.1]
  def change
    add_column :deposits, :is_settled, :boolean
  end
end
