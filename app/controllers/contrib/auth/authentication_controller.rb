module Contrib
  module Auth
    class AuthenticationController < ApplicationController
      def sign_in_with_password
        @response = Contrib::Auth.api.sign_in_with_password(
          params[:email_or_username],
          params[:password]
        )
      end

      def reset_password
        @response = Contrib::Auth::api.reset_password(
          params[:email_or_username]
        )

        render json: {}, status: :ok
      end

      def sign_up_with_email_or_username_and_password
        @response = Contrib::Auth.api.sign_up_with_email_and_password(
          params[:email_or_username],
          params[:password]
        )
      end

      def change_password
        @response = Contrib::Auth.api.change_password(
          params[:id_token],
          params[:password],
          params[:password_confirmation],
        )
      end

      def certificates
        render json: Contrib::Auth.api.certificates, status: :ok
      end
    end
  end
end
