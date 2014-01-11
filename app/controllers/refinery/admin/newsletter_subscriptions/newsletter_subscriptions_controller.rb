module Refinery
  module Admin
    module NewsletterSubscriptions
      class NewsletterSubscriptionsController < Refinery::AdminController

        crudify :'refinery/newsletter_subscriptions/newsletter_subscription',
                order: 'id ASC'

        def index
          @newsletter_subscriptions = find_all_newsletter_subscriptions.subscribed
          @grouped_newsletter_subscriptions = group_by_date(@newsletter_subscriptions)
        end

        def unsubscribed
          @newsletter_subscriptions = find_all_newsletter_subscriptions.unsubscribed

          @grouped_newsletter_subscriptions = group_by_date(@newsletter_subscriptions)

          render action: :index
        end

        def toggle_subscribed
          find_newsletter_subscription
          @newsletter_subscription.toggle!(:subscribed)

          redirect_to :back
        end

      end
    end
  end
end
