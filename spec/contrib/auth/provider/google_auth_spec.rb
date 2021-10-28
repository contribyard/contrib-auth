require 'spec_helper'

RSpec.describe Contrib::Auth::Provider::GoogleAuth, provider: true do
  describe '#sign_up_with_email_and_password' do
    context 'when success' do
      it 'builds the correct request' do
        http_client = spy('Faraday::Connection')
        # response body does not matter on this example.
        allow(http_client).to receive(:post).and_return(OpenStruct.new(body: '{}'))

        api_key  = SecureRandom.uuid
        email    = 'developers@contribyard'
        password = '12345'

        provider = Contrib::Auth::Provider::GoogleAuth.new(api_key, http_client)
        provider.sign_up_with_email_and_password(email, password)

        expect(http_client).to have_received(:post).with('/v1/accounts:signUp') do |&block|
          req = OpenStruct.new(params: {}, body: '{}', headers: {})
          block.call(req)

          expect(req.headers).to eq 'Content-Type' => 'application/json'
          expect(req.params).to eq key: api_key
          expect(req.body).to eq "{\"email\":\"#{email}\",\"password\":\"#{password}\",\"returnSecureToken\":true}"
        end
      end

      it 'returns the correct response' do
        api_key  = SecureRandom.uuid
        email    = 'developers@contribyard'
        password = '12345'

        provider = Contrib::Auth::Provider::GoogleAuth.new(api_key)
        response = provider.sign_in_with_password(email, password)

        expect(response.expires_in).to eq '3600'
        expect(response.refresh_token).to eq '[REFRESH_TOKEN]'
        expect(response.id_token).to eq '[ID_TOKEN]'
      end
    end

    context 'when credentials are not correct' do
      pending
    end
  end

  describe '#sign_in_with_password' do
    context 'when credentials are correct' do
      it 'builds the correct request' do
        http_client = spy('Faraday::Connection')
        # response body does not matter on this example.
        allow(http_client).to receive(:post).and_return(OpenStruct.new(body: '{}'))

        api_key  = SecureRandom.uuid
        email    = 'developers@contribyard'
        password = '12345'

        provider = Contrib::Auth::Provider::GoogleAuth.new(api_key, http_client)
        provider.sign_in_with_password(email, password)

        expect(http_client).to have_received(:post).with('/v1/accounts:signInWithPassword') do |&block|
          req = OpenStruct.new(params: {}, body: '{}', headers: {})
          block.call(req)

          expect(req.headers).to eq 'Content-Type' => 'application/json'
          expect(req.params).to eq key: api_key
          expect(req.body).to eq "{\"email\":\"#{email}\",\"password\":\"#{password}\",\"returnSecureToken\":true}"
        end
      end

      it 'returns the correct response' do
        api_key  = SecureRandom.uuid
        email    = 'developers@contribyard'
        password = '12345'

        provider = Contrib::Auth::Provider::GoogleAuth.new(api_key)
        response = provider.sign_in_with_password(email, password)

        expect(response.expires_in).to eq '3600'
        expect(response.refresh_token).to eq '[REFRESH_TOKEN]'
        expect(response.id_token).to eq '[ID_TOKEN]'
      end
    end

    context 'when credentials are not correct' do
      pending
    end
  end

  describe '#reset_password' do
    context 'when the API responds correctly' do
      it 'builds the correct request' do
        http_client = spy('Faraday::Connection')
        # response body does not matter on this example.
        allow(http_client).to receive(:post).and_return(OpenStruct.new(body: '{}'))

        api_key  = SecureRandom.uuid
        email    = 'developers@contribyard'

        provider = Contrib::Auth::Provider::GoogleAuth.new(api_key, http_client)
        provider.reset_password(email)

        expect(http_client).to have_received(:post).with('/v1/accounts:sendOobCode') do |&block|
          req = OpenStruct.new(params: {}, body: '{}', headers: {})
          block.call(req)

          expect(req.headers).to eq 'Content-Type' => 'application/json'
          expect(req.params).to eq key: api_key
          expect(req.body).to eq "{\"email\":\"#{email}\",\"requestType\":\"PASSWORD_RESET\"}"
        end
      end

      it 'returns the correct response' do
        api_key  = SecureRandom.uuid
        email    = 'developers@contribyard'

        provider = Contrib::Auth::Provider::GoogleAuth.new(api_key)
        response = provider.reset_password(email)

        expect(response).to be_truthy

      end
    end
  end
end
