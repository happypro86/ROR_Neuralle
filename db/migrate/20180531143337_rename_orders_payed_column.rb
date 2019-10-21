class RenameOrdersPayedColumn < ActiveRecord::Migration
  def change
    rename_column :orders, :payed, :paid
  end
end
