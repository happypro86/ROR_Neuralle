class AddSpecificsFieldsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :specifics_business, :integer
    add_column :orders, :specifics_goal, :integer
    add_column :orders, :specifics_regularity, :integer
    add_column :orders, :specifics_style, :integer
  end
end
