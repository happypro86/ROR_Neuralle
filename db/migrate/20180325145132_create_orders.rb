class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.boolean :terms_agreed
      t.float :total_price
      t.integer :subscription_type, default: 2
      t.references :plan, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
