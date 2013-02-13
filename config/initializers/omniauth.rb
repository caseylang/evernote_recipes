OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :evernote, ENV['EVERNOTE_CONSUMER_KEY'], ENV['EVERNOTE_CONSUMER_SECRET'],
           :client_options => { :site => 'https://sandbox.evernote.com' }
end

if Rails.env.production? && ENV['DEMO_MODE']
  # Turn on 'test mode' for OmniAuth when in production for demo
  OmniAuth.config.test_mode = true
  demo_config = Rails.root.join("config/demo/evernote_demo_user.yml")
  evernote_yml = YAML.load(ERB.new(File.read(demo_config)).result)
  OmniAuth.config.mock_auth[:evernote] = OmniAuth::AuthHash.new evernote_yml
end