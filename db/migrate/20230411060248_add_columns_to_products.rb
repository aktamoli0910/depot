class AddColumnsToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :enabled, :boolean
    add_column :products, :discount_price, :decimal
    add_column :products, :permalink, :string
    change_column_default :products, :enabled, from: true, to: false
  end
end
