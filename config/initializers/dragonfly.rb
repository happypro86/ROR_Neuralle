Dragonfly.app.configure do
  url_host = 'https://cdn.neuralle.com' if Rails.env.production?
end
