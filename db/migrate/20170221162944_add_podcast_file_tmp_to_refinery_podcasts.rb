class AddPodcastFileTmpToRefineryPodcasts < ActiveRecord::Migration
  def change
    add_column :refinery_podcasts, :podcast_file_tmp, :string
  end
end
