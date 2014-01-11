module Refinery
  module NewsletterSubscriptions
    class Mailer < ActionMailer::Base

      def confirmation(newsletter_subscription)
        @newsletter_subscription = newsletter_subscription
        mail subject:   Refinery::NewsletterSubscriptions::Setting.confirmation_subject,
             to:        newsletter_subscription.email,
             from:      "#{Refinery::Core.site_name} <#{Refinery::Core.site_emails_emitter}>",
             reply_to:  Refinery::NewsletterSubscriptions::Setting.notification_recipients.split(',').first
      end

      def notification(newsletter_subscription)
        @newsletter_subscription = newsletter_subscription
        mail subject:   Refinery::NewsletterSubscriptions::Setting.notification_subject,
             to:        Refinery::NewsletterSubscriptions::Setting.notification_recipients,
             from:      "#{Refinery::Core.site_name} <#{Refinery::Core.site_emails_emitter}>",
             reply_to:  newsletter_subscription.email
      end

    end
  end
end
