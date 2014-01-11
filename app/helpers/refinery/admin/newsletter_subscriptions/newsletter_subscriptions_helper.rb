module Refinery
  module Admin
    module NewsletterSubscriptions
      module NewsletterSubscriptionsHelper

        def subscribed_count
          @subscribed_count ||= Refinery::NewsletterSubscriptions::NewsletterSubscription.subscribed.count
        end

        def unsubscribed_count
          @unsubscribed_count ||= Refinery::NewsletterSubscriptions::NewsletterSubscription.unsubscribed.count
        end
      end
    end
  end
end
