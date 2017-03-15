Refinery::Core::Engine.routes.draw do

  namespace :newsletter_subscriptions do
    resources :newsletter_subscriptions, path: '', only: [:index, :new, :create] do
      collection do
        get :thank_you
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
