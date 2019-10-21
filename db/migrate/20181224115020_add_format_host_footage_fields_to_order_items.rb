class AddFormatHostFootageFieldsToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :format_custom, :boolean, default: false
    add_column :order_items, :host_budget, :integer, default: 0
    add_column :order_items, :footage_per_hour, :integer, default: 0
  end
end
