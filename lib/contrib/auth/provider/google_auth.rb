require 'faraday'

module Contrib
  module Auth
    module Provider
      class GoogleAuth
        DEFAULT_BASE_ENDPOINT = 'https://identitytoolkit.googleapis.com'.freeze

        def initialize(api_key, http_client = Faraday.new(DEFAULT_BASE_ENDPOINT))
          @api_key       = api_key
          @http_client   = http_client
        end

        # refers to: https://firebase.google.com/docs/reference/rest/auth#section-create-email-password
        def sign_up_with_email_and_password(email_or_username, password)
          response = @http_client.post('/v1/accounts:signUp') do |req|
            req.params[:key] = @api_key
            req.headers['Content-Type'] = 'application/json'
            req.body = JSON.generate(
              email: email_or_username,
              password: password,
              returnSecureToken: true,
            )
          end

          parsed_response = JSON.parse(response.body)

          # TODO: Handle errors
          Contrib::Auth::Provider::Responses::SignUpWithEmailAndPassword.new(
            id_token:       parsed_response['idToken'],
            refresh_token:  parsed_response['refreshToken'],
            expires_in:     parsed_response['expiresIn'],
          )
        end

        # refers to: https://firebase.google.com/docs/reference/rest/auth#section-sign-in-email-password
        def sign_in_with_password(email_or_username, password)
          response = @http_client.post('/v1/accounts:signInWithPassword') do |req|
            req.params[:key] = @api_key
            req.headers['Content-Type'] = 'application/json'
            req.body = JSON.generate(
              email: email_or_username,
              password: password,
              returnSecureToken: true,
            )
          end

          parsed_response = JSON.parse(response.body)

          # TODO: Handle errors
          Contrib::Auth::Provider::Responses::SignInWithPassword.new(
            id_token:       parsed_response['idToken'],
            refresh_token:  parsed_response['refreshToken'],
            expires_in:     parsed_response['expiresIn'],
          )
        end

        # refers to: https://firebase.google.com/docs/reference/rest/auth#section-send-password-reset-email
        def reset_password(email_or_username)
          # TODO: X-Firebase-Locale optional header
          response = @http_client.post('/v1/accounts:sendOobCode') do |req|
            req.params[:key] = @api_key
            req.headers['Content-Type'] = 'application/json'

            req.body = JSON.generate(
              email: email_or_username,
              requestType: 'PASSWORD_RESET',
            )
          end

          response.success?
        end
      end
    end
  end
end
