require 'spec_helper'

RSpec.describe Contrib::Auth::Provider::GoogleAuth, provider: true do
  describe '.sign_in_with_password' do
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

        expect(http_client).to have_received(:post).with('accounts:signInWithPassword') do |&block|
          req = OpenStruct.new(params: {}, body: '{}')
          block.call(req)
          expect(req.params).to eq key: api_key
          expect(req.body).to eq "{\"email\":\"#{email}\",\"password\":\"#{password}\"}"
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
end
