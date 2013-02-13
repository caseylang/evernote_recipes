OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :evernote, ENV['EVERNOTE_CONSUMER_KEY'], ENV['EVERNOTE_CONSUMER_SECRET'],
           :client_options => { :site => 'https://sandbox.evernote.com' }
end

if Rails.env.production?
  # Turn on 'test mode' for OmniAuth when in production for demo
  OmniAuth.config.test_mode = true
  evernote_yml = YAML.load_file(Rails.root.join("config/demo/evernote_demo_user.yml"))
  OmniAuth.config.mock_auth[:evernote] = OmniAuth::AuthHash.new evernote_yml
end