require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Load environment variable overrides.
begin
  config = YAML.load_file(File.expand_path('../env_vars.yml', __FILE__))
  config.each do |k, v|
    ENV[k.to_s] = v.to_s
  end
rescue Errno::ENOENT
end