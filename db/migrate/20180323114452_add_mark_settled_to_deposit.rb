# frozen_string_literal: true

class AddMarkSettledToDeposit < ActiveRecord::Migration[5.1]
  def change
    add_column :deposits, :mark_settled, :boolean
  end
end
