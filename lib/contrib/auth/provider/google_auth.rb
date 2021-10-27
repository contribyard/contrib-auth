require 'faraday'

module Contrib
  module Auth
    module Provider
      class GoogleAuth
        DEFAULT_BASE_ENDPOINT = 'https://identitytoolkit.googleapis.com/v1'.freeze

        def initialize(api_key, base_endpoint = DEFAULT_BASE_ENDPOINT)
          @api_key       = api_key
          @base_endpoint = base_endpoint
        end

        def sign_in_with_password(email_or_username, password)
          connection.post('accounts:signInWithPassword') do |req|
            req.params[:key] = @api_key
            req.body = JSON.generate(email: email_or_username, password: password)
          end
        end

        private

        def connection
          @connection ||= Faraday.new(@base_endpoint)
        end
      end
    end
  end
end
