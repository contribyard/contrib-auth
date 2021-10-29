module Contrib
  module Auth
    class Api
      def initialize(provider = nil)
        @provider = provider
      end

      def sign_in_with_password(email_or_username, password)
        raise ArgumentError unless email_or_username
        raise ArgumentError unless password
        # TODO: Implement retryable
        # TODO: Validate incoming attributes
        @provider.sign_in_with_password(email_or_username, password)
      end

      def reset_password(email_or_username)
        @provider.reset_password(email_or_username)
      end

      def sign_up_with_email_and_password(email_or_username, password)
        raise ArgumentError unless email_or_username
        raise ArgumentError unless password

        # TODO: ask for password confirmation
        @provider.sign_up_with_email_and_password(email_or_username, password)
      end

      def certificates
        @provider.certificates
      end
    end
  end
end
