Refinery::Videos.configure do |config|
    #Configures the maximum allowed upload size (in bytes) for an video file
    #config.max_file_size = 524288000

    # Configure how many videos per page should be displayed in the list of images in the admin area
    #config.pages_per_admin_index =  20

    # Configure white-listed mime types for validation
    # config.whitelisted_mime_types = ["video/mp4", "video/x-flv", "application/ogg", "video/webm", "video/flv", "video/ogg"]

    # Configure skin. Put css class name to activate skin. For YouTube like skin put tubecss and add css with images to assets path.
    # config.skin_css_class = vjs-default-skin

    # Configure Dragonfly
    # config.dragonfly_verify_urls = true
    # config.dragonfly_secret = "6fb40e2e968ecd014aea8f77a47eb163a3d2cb796c95039b"
    config.dragonfly_url_format = "/system/videos/:job/:basename.:format"
    config.dragonfly_url_host = Rails.application.config.action_controller.asset_host
    # config.datastore_root_path = "/home/elmirill/Development/neuralle/public/system/refinery/videos"

    # Configure Dragonfly custom storage backend
    # The custom_backend setting by default defers to the core setting for this but can be set just for videos.
    # config.custom_backend_class = nil
    # config.custom_backend_opts = {}

    # Configure S3 (you can also use ENV for this)
    # The s3_backend setting by default defers to the core setting for this but can be set just for videos.
    # config.s3_backend = Refinery::Core.s3_backend
    # config.s3_bucket_name = ENV['S3_BUCKET']
    # config.s3_access_key_id = ENV['S3_KEY']
    # config.s3_secret_access_key = ENV['S3_SECRET']
    # config.s3_region = ENV['S3_REGION']
end
