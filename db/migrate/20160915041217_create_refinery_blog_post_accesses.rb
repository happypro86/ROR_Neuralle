class CreateRefineryBlogPostAccesses < ActiveRecord::Migration
  def change
    create_table :refinery_blog_post_accesses do |t|
      t.integer :post_id

      t.timestamps null: false

      enable_extension "intarray"
    end

    add_index :refinery_blog_post_accesses, :created_at
  end
end
