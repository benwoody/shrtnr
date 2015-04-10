OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, TWITTER[:client_id], TWITTER[:client_secret]
end
