plugin = Refinery::Plugins['newsletter_subscriptions']
if plugin
  Refinery::Core::Engine.routes.draw do
    # Frontend routes
    if plugin.page.present? && Refinery::Pages.marketable_urls
      Globalize.with_locales plugin.page.translated_locales do |locale|
        get plugin.page.nested_path,
          to: 'newsletter_subscriptions/newsletter_subscriptions#new',
          as: "new_newsletter_subscriptions_newsletter_subscription_#{locale}"
        post plugin.page.nested_path,
          to: 'newsletter_subscriptions/newsletter_subscriptions#create',
          as: "newsletter_subscriptions_newsletter_subscriptions_#{locale}"
      end
    else
      namespace :newsletter_subscriptions do
        resources :newsletter_subscriptions, path: '', only: [:index, :new, :create] do
          collection do
            get :thank_you
          end
        end
      end
    end

    # Admin routes
    namespace :admin, path: Refinery::Core.backend_route do
      namespace :newsletter_subscriptions do
        resources :newsletter_subscriptions, only: [:index, :destroy] do
          collection do
            get :unsubscribed
          end
          member do
            get :toggle_subscribed
          end
        end
        resources :settings, only: [:edit, :update]
      end
    end
  end
end
