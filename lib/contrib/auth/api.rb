module Contrib
  module Auth
    class Api
      def initialize(provider = nil)
        @provider = provider
      end

      def sign_in_with_password(email_or_username, password)
        # TODO: Implement retryable
        @provider.sign_in_with_password(email_or_username, password)
      end

      def reset_password(email_or_username)
        @provider.reset_password(email_or_username)
      end

      def sign_up_with_email_and_password(email_or_username, password)
        @provider.sign_up_with_email_and_password(email_or_username, password)
      end
    end
  end
end
