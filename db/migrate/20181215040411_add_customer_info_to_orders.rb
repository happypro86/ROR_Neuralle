class AddCustomerInfoToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :name, :string
    add_column :orders, :email, :string
    add_column :orders, :phone_number, :string
    add_column :orders, :country, :string
  end
end
