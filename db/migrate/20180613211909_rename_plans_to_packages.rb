class RenamePlansToPackages < ActiveRecord::Migration
  def change
    rename_table :plans, :packages
    rename_column :orders, :plan_id, :package_id
  end
end
