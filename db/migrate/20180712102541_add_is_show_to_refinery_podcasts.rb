class AddIsShowToRefineryPodcasts < ActiveRecord::Migration
  def change
    add_column :refinery_podcasts, :is_show, :boolean, default: true
  end
end
