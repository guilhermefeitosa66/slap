class CreateInventoryUsers < ActiveRecord::Migration
  def change
    create_table :inventory_users do |t|
      t.references :inventory, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
