module Refinery
  module NewsletterSubscriptions
    class Setting < Refinery::Core::BaseModel

      class << self
        def confirmation_message
          Refinery::Setting.find_by(
            name: "confirmation_email_message_#{Globalize.locale}",
            scoping: 'newsletter_subscriptions'
          ).value
        end

        def confirmation_subject
          Refinery::Setting.find_by(
            name: "confirmation_email_subject_#{Globalize.locale}",
            scoping: 'newsletter_subscriptions'
          ).value
        end

        def notification_recipients
          Refinery::Setting.find_by(
            name: 'notification_email_recipients',
            scoping: 'newsletter_subscriptions'
          ).value
        end

        def notification_subject
          Refinery::Setting.find_by(
            name: 'notification_email_subject',
            scoping: 'newsletter_subscriptions'
          ).value
        end

      end

    end
  end
end
