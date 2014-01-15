class CreateNewsletterSubscriptions < ActiveRecord::Migration

  def up
    create_table :refinery_newsletter_subscriptions do |t|
      t.string :email, null: false
      t.boolean :subscribed, null: false, default: true

      t.timestamps null: false
    end

    add_index :refinery_newsletter_subscriptions, :updated_at
    add_index :refinery_newsletter_subscriptions, :email, unique: true
  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all name: 'newsletter_subscriptions'
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.destroy_all plugin_page_id: ['newsletter_subscriptions', 'newsletter_subscriptions_thank_you']
    end

    drop_table :refinery_newsletter_subscriptions
  end

end
