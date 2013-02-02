Rails.application.config.generators do |g|
  g.helper false
  g.javascripts false
  g.stylesheet_engine :scss
  g.test_framework :rspec
  g.template_engine :haml
end
