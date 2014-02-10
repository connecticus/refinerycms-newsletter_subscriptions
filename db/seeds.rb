require 'refinery/user'
require 'refinery/page'
require 'refinery/setting'

plugin = Refinery::Plugins['newsletter_subscriptions']
if plugin

  Refinery::User.all.each do |user|
    if user.plugins.find_by(name: plugin.name).nil?
      user.plugins.create(name: plugin.name,
                          position: (user.plugins.maximum(:position) || -1) +1)
    end
  end

  pages = {
    newsletter_subscriptions: {
      title: 'Newsletter Subscriptions',
      deletable: false,
      status: 'live',
      show_in_menu: false,
      plugin_page_id: plugin.name
    },
    newsletter_subscriptions_thank_you: {
      title: 'Thank You',
      plugin_page_id: 'newsletter_subscriptions_thank_you',
      deletable: false,
      status: 'live',
      show_in_menu: false,
      parent: :newsletter_subscriptions    }
  }

  Refinery::Pages::Import.new(plugin, pages, false).run

  confirmation_email = {
    subject: "Thank you for your newsletter subscription - #{Refinery::Core.site_name}",
    message: "Hello %name%,\n\nThis email is a receipt to confirm we have received your newsletter subscription and we'll be in touch shortly.\n\nThanks."
  }

  Refinery::I18n.frontend_locales.each do |locale|
    confirmation_email.each do |key, val|
      setting = Refinery::Setting.where(
        name: "confirmation_email_#{key}_#{locale}",
        scoping: 'newsletter_subscriptions',
        destroyable: false,
        restricted: true
      ).first_or_initialize

      setting.update_attributes(value: val) if setting.value.blank?
    end
  end

  notification_email = {
    recipients: Refinery::Core.site_emails_receiver,
    subject: "#{Refinery::Core.site_name} - New newsletter subscription"
  }

  notification_email.each do |key, val|
    setting = Refinery::Setting.where(
      name: "notification_email_#{key}",
      scoping: 'newsletter_subscriptions',
      destroyable: false,
      restricted: true
    ).first_or_initialize

    setting.update_attributes(value: val) if setting.value.blank?
  end

  if defined? Refinery::Snippets
    require 'refinery/snippet'

    newsletter_subscription_snippet = Refinery::Snippet.where(
      title: 'Newsletter Subscription',
      snippet_type: 'template',
      canonical_friendly_id: 'newsletter-subscription'
    ).first_or_initialize

    Globalize.with_locales(Refinery::I18n.frontend_locales) do |locale|
      newsletter_subscription_snippet.update_attributes(
        body: '/refinery/snippets/newsletter_subscription',
        title: newsletter_subscription_snippet.title
      )
    end
  end
end
