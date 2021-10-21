class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.string :year
      t.string :campus
      t.string :file

      t.timestamps null: false
    end
  end
end
