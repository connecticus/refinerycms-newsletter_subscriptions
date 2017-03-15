module Refinery
  module NewsletterSubscriptions
    class NewsletterSubscriptionsController < ::ApplicationController

      before_action :find_page, only: [:create, :new]

      def index
        redirect_to action: :new
      end

      def thank_you
        #@page = Page.find_by(link_url: Refinery::NewsletterSubscriptions.page_path_thank_you)
      end

      def new
        @newsletter_subscription = NewsletterSubscription.new
      end

      def create
        @newsletter_subscription = NewsletterSubscription.new(newsletter_subscription_params)

        if @newsletter_subscription.save
          begin
            Mailer.notification(@newsletter_subscription).deliver
          rescue => e
            logger.warn "There was an error delivering the newsletter_subscription notification.\n#{e.message}\n"
          end

          begin
            Mailer.confirmation(@newsletter_subscription).deliver
          rescue => e
            logger.warn "There was an error delivering the newsletter_subscription confirmation:\n#{e.message}\n"
          end

          redirect_to refinery.url_for((thank_you_page || page).url), status: :see_other
        else
          render action: :new
        end
      end

    protected

      def find_page
        #@page = Page.find_by(link_url: Refinery::NewsletterSubscriptions.page_path_new)
      end

    private

      def newsletter_subscription_params
        params.require(:newsletter_subscription).permit(:email)
      end

    end
  end
end
