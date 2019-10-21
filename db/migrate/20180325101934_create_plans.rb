class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.integer :position
      t.string :name
      t.float :price
      t.text :description
      t.string :features

      t.timestamps null: false
    end
  end
end
