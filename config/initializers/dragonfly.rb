require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "9a8be7e22f99bee1e972af4327cbca662ee886b99d4d0b7ff5ef0d6a2558f8ee"

  url_format "/media/:job/:name"

  datastore :s3,
    bucket_name: ENV['AWS_USER_NAME'],
    access_key_id: ENV['AWS_ACCESS_KEY'],
    secret_access_key: ENV['AWS_SECRET_KEY']
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware
