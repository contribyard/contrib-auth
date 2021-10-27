module Contrib
  module Auth
    class AuthenticationController < ApplicationController
      def sign_in_with_password
        @response = Contrib::Auth.api.sign_in_with_password(
          params[:email_or_username],
          params[:password]
        )
      end
    end
  end
end
