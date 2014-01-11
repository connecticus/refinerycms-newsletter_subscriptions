require 'refinerycms-core'
require 'refinerycms-settings'

module Refinery
  module NewsletterSubscriptions
    require 'refinery/newsletter_subscriptions/engine'

    class << self
      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end
    end
  end
end
