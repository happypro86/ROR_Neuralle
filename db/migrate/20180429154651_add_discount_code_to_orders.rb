class AddDiscountCodeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :discount_code, :string
    add_column :orders, :discount_code_applied, :boolean, default: false
  end
end
