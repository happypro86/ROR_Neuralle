Refinery::Podcasts::Admin::PodcastsController.prepend(
  Module.new do
    def permitted_podcast_params
      super << [:file_url, :podcast_file, :is_show]
    end
  end
)

Refinery::Podcasts::Admin::PodcastsController.class_eval do

  def new
    @podcast = Refinery::Podcasts::Podcast.new
    @podcast.process_podcast_file_upload = true
    @uploader = @podcast.podcast_file
    @uploader.success_action_redirect = podcasts_admin_podcasts_url
  end

end
