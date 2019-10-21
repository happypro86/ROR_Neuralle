class CreateBriefRequests < ActiveRecord::Migration
  def change
    create_table :brief_requests do |t|
      t.string :name
      t.string :company
      t.string :email
      t.string :phone_number
      t.string :region
      t.text :brief_structure
      t.text :brief_description
      t.string :brief_file

      t.timestamps null: false
    end
  end
end
