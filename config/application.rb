require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"
require 'rails/mongoid'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SlackLogViewer
  class Application < Rails::Application
    config.time_zone = 'Asia/Tokyo'
  end
end
