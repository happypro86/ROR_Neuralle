class ChangeDefaultPaymentToOnceOff < ActiveRecord::Migration
  def change
    change_column :orders, :subscription_type, :integer, default: 1
  end
end
