CarrierWave.configure do |config|
  config.max_file_size = 500.megabytes
  # config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV["S3_KEY"],
    aws_secret_access_key: ENV["S3_SECRET"],
    region:                ENV["S3_REGION"],
    host:                  ENV["S3_HOST_NAME"]
  }
  config.fog_directory  = ENV["S3_BUCKET"]
  config.fog_public     = true
  config.asset_host = "https://cdn.neuralle.com"
end
