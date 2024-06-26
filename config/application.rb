require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsRede
  class Application < Rails::Application
    config.autoload_paths << "#{root}/app/views"
    config.autoload_paths << "#{root}/app/views/layouts"
    config.autoload_paths << "#{root}/app/views/components"
    config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework :rspec, fixture: false
      generate.helper_specs :false
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.active_storage.replace_on_assign_to_many = false

    config.i18n.default_locale = :'pt-BR'

    config.active_storage.variant_processor = :mini_magick

    config.after_initialize do
      ActionText::ContentHelper.allowed_attributes.add 'style'
      ActionText::ContentHelper.allowed_attributes.add 'controls'
      ActionText::ContentHelper.allowed_attributes.add 'poster'

      # ActionText::ContentHelper.allowed_tags.add 'video'
      # ActionText::ContentHelper.allowed_tags.add 'source'
      ActionText::ContentHelper.allowed_tags.add 'centered-div'
      ActionText::ContentHelper.allowed_tags.add 'right-div'
      ActionText::ContentHelper.allowed_tags.add 'justified-div'
      ActionText::ContentHelper.allowed_tags.add 'left-div'
      ActionText::ContentHelper.allowed_tags.add 'image-small'
      ActionText::ContentHelper.allowed_tags.add 'image-medium'
      ActionText::ContentHelper.allowed_tags.add 'image-large'
    end
  end

end
