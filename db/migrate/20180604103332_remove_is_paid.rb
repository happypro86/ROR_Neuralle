class RemoveIsPaid < ActiveRecord::Migration
  def change
    remove_column :orders, :is_paid, :boolean
  end
end
