module Refinery
  module NewsletterSubscriptions
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::NewsletterSubscriptions

      engine_name :refinery_newsletter_subscriptions

      initializer 'register newsletter_subscriptions plugin' do
        Refinery::Plugin.register do |plugin|
          plugin.name = 'newsletter_subscriptions'
          plugin.url = proc {
            Refinery::Core::Engine.routes.url_helpers.admin_newsletter_subscriptions_newsletter_subscriptions_path
          }
          plugin.pathname = root
          plugin.activity = {
            class_name: :'refinery/newsletter_subscriptions/newsletter_subscription',
            url_prefix: ''
          }
        end
      end

      initializer 'reload routes', after: :set_routes_reloader_hook do
        Rails.application.routes_reloader.reload!
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::NewsletterSubscriptions)
      end
    end
  end
end
