require 'capybara/rails'
require 'capybara/rspec'

Capybara.configure do |config|
  config.default_driver = :selenium_chrome # Use :selenium_chrome_headless for headless testing
  config.server = :puma, { Silent: true }
  config.javascript_driver = :selenium_chrome
  config.default_max_wait_time = 10
end