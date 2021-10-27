require 'faraday'

module Contrib
  module Auth
    module Provider
      class GoogleAuth
        DEFAULT_BASE_ENDPOINT = 'https://identitytoolkit.googleapis.com/v1'.freeze

        def initialize(api_key, http_client = Faraday.new(DEFAULT_BASE_ENDPOINT))
          @api_key       = api_key
          @http_client   = http_client
        end

        # refers to: https://firebase.google.com/docs/reference/rest/auth#section-sign-in-email-password
        def sign_in_with_password(email_or_username, password)
          response = @http_client.post('accounts:signInWithPassword') do |req|
            req.params[:key] = @api_key
            req.body = JSON.generate(email: email_or_username, password: password)
          end

          parsed_response = JSON.parse(response.body)

          # TODO: Handle errors
          Contrib::Auth::Provider::Responses::SignInWithPassword.new(
            id_token:       parsed_response['idToken'],
            refresh_token:  parsed_response['refreshToken'],
            expires_in:     parsed_response['expiresIn'],
          )
        end
      end
    end
  end
end
