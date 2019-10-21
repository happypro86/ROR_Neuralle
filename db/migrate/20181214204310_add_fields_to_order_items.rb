class AddFieldsToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :duration, :integer, default: 0
    add_column :order_items, :format_horizontal, :boolean, default: true
    add_column :order_items, :format_vertical, :boolean, default: false
    add_column :order_items, :format_square, :boolean, default: false
  end
end
