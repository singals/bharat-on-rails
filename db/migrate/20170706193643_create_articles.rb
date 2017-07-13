class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :name
      t.string :package_quantity
      t.integer :availabe_units
      t.float :mrp
      t.float :cost
      t.boolean :is_active

      t.timestamps
    end
  end
end
