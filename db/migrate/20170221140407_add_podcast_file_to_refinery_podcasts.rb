class AddPodcastFileToRefineryPodcasts < ActiveRecord::Migration
  def change
    add_column :refinery_podcasts, :podcast_file, :string
  end
end
