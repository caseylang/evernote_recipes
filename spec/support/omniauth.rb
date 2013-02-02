# Turn on 'test mode' for OmniAuth
OmniAuth.config.test_mode = true
evernote_yml = YAML.load_file(Rails.root.join("spec/fixtures/evernote_test_user.yml"))
OmniAuth.config.mock_auth[:evernote] = OmniAuth::AuthHash.new evernote_yml