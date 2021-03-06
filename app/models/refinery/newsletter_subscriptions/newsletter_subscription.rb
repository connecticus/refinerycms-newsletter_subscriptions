module Refinery
  module NewsletterSubscriptions
    class NewsletterSubscription < Refinery::Core::BaseModel
      self.table_name = 'refinery_newsletter_subscriptions'

      default_scope -> { order(id: :desc) }
      scope :subscribed, -> { where(subscribed: true) }
      scope :unsubscribed, -> { where(subscribed: false) }

      alias_attribute :name, :email
      alias_attribute :title, :name

      validates :email, presence: true, uniqueness: true

      def message
        subscribed? ? 'unsubscribed' : 'subscribed'
      end

      def unsubscribed?
        !subscribed?
      end
    end
  end
end
