class AddIsSettledToSale < ActiveRecord::Migration[5.1]
  def change
    add_column :sales, :is_settled, :boolean
  end
end
