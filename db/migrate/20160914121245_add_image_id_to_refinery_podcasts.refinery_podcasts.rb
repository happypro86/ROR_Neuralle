# This migration comes from refinery_podcasts (originally 3)
class AddImageIdToRefineryPodcasts < ActiveRecord::Migration

  def change
    add_column :refinery_podcasts, :image_id, :integer
    add_index :refinery_podcasts, :image_id
  end

end
