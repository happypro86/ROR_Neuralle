# This migration comes from refinery_footers (originally 1)
class CreateFootersFooters < ActiveRecord::Migration

  def up
    create_table :refinery_footers do |t|
      t.string :title
      t.string :text
      t.string :link
      t.string :icon
      t.string :placement
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-footers"})
    end

    drop_table :refinery_footers

  end

end
