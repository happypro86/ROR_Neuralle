class AddFileUrlToRefineryPodcasts < ActiveRecord::Migration
  def change
    add_column :refinery_podcasts, :file_url, :string
  end
end
