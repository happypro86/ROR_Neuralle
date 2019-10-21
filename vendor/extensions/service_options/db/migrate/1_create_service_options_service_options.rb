class CreateServiceOptionsServiceOptions < ActiveRecord::Migration

  def up
    create_table :refinery_service_options do |t|
      t.string :title
      t.text :description
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-service_options"})
    end

    drop_table :refinery_service_options

  end

end
