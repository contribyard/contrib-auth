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

  describe '#certificates' do
    it 'returns the correct response' do
      api_key  = SecureRandom.uuid

      provider = Contrib::Auth::Provider::GoogleAuth.new(api_key)
      response = provider.certificates

      expect(response).to eq(
        '8fbdf241e7c3a65135606ddc1fed2c5522630a87' => "-----BEGIN CERTIFICATE-----\nMIIDHDCCAgSgAwIBAgIIBliQEo9XAGgwDQYJKoZIhvcNAQEFBQAwMTEvMC0GA1UE\nAxMmc2VjdXJldG9rZW4uc3lzdGVtLmdzZXJ2aWNlYWNjb3VudC5jb20wHhcNMjEx\nMDE1MDkyMDI1WhcNMjExMDMxMjEzNTI1WjAxMS8wLQYDVQQDEyZzZWN1cmV0b2tl\nbi5zeXN0ZW0uZ3NlcnZpY2VhY2NvdW50LmNvbTCCASIwDQYJKoZIhvcNAQEBBQAD\nggEPADCCAQoCggEBAJ1TWJ5J++eu7GvaPYUZ7IR+MUF98zVvVB/Dnt2riLETfIV7\ndHsuJV96B1C0QiU/IN3TtVcsxtvkWEZeo3cVAgYZ0lMkMfw3CZCG/8cO+5KPT1TX\nsc8Q7h7lQ70dE2HEBdJVaTuAgpo+TQwKQeCH4i8Moh13wwOcIeS4J0agozxnpe1J\nUPdgBDj+0ezrD9coNyRnTX8rQvFVAOcZX/jDm0zVHJFriJqW2YbQOFNlxb5QPadH\nSrDt0NBttVRtZWMtW9i1ujJWvE9OOOXGrE23eOxZNy7yfmV6Ux1qzVsy1S+U2CbN\n/OwBjhydAuRcwvsr/T0koilmomGdRHK60KzrTlMCAwEAAaM4MDYwDAYDVR0TAQH/\nBAIwADAOBgNVHQ8BAf8EBAMCB4AwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwIwDQYJ\nKoZIhvcNAQEFBQADggEBACuU6QpmAO/6m2PEwC/4Q8N1EAD6Lk1F4c9F5UzGVpQ3\nWu3S2vQDqYMwALRGeUx6TOAAghku+4wqwEQ5bxCFJuYjuojCo5XMiwuLW7gef0Mh\nXfTABXJuXRYREnHL6oFvwNi4vgWdEvoUNEA+U2uSdNIPDNZzr731hKlUIOGlDDBm\nuARxRZHy/5tFrcXAgXEK4ZrP9Im7ohr5ZwDyo6+aOZ7gQLW+WlgHuANy+4drzywa\nje2goxQzXATft/X8ZX5SbP9aOoEUOEE370DaLfdaJOuSCBh/iObrssAHTRtDgDQT\naBQiOyfLnPLMAWYJ+YQpvFyQ4+x7dz5UDoZqmtSgyWw=\n-----END CERTIFICATE-----\n",
        '152555a22371f10f4e22f1ace762fc50ff3bee0c' => "-----BEGIN CERTIFICATE-----\nMIIDHDCCAgSgAwIBAgIIW4K0b18ff70wDQYJKoZIhvcNAQEFBQAwMTEvMC0GA1UE\nAxMmc2VjdXJldG9rZW4uc3lzdGVtLmdzZXJ2aWNlYWNjb3VudC5jb20wHhcNMjEx\nMDIzMDkyMDI1WhcNMjExMTA4MjEzNTI1WjAxMS8wLQYDVQQDEyZzZWN1cmV0b2tl\nbi5zeXN0ZW0uZ3NlcnZpY2VhY2NvdW50LmNvbTCCASIwDQYJKoZIhvcNAQEBBQAD\nggEPADCCAQoCggEBAKS+ibhJlzF0VtSc6jv0G0fRlk3IFZ9YZ/GjQqangoOwZHe4\nP7U2s0huTY8YINQ6tnycJLYDNgMM0PV+y+5nGleZ1Z4dTn3Z2g7i3SRfgIhEe9fi\nVAQ+PkZ8RvPFkBVHCyiwfoGrfaW6FthEGhNcwZxuGSfzBcLPqOj/P49uFl6lY4+u\n7ZZZRusSfTznIS+hSS28S9H3zGw3j6XCWvgxbickiISZljUg84HqwCzS+9Ox5jMF\nDpXzlmJjxG1vc9IODICp7wzZSuAvnwV+td1Poigq7J8ZnUjs/y8Y5mIj10/gsL0W\nVZODeH4BIjdEoWdLlQUeBaQR3SHERI2ECK6ZKycCAwEAAaM4MDYwDAYDVR0TAQH/\nBAIwADAOBgNVHQ8BAf8EBAMCB4AwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwIwDQYJ\nKoZIhvcNAQEFBQADggEBAFju33PuM5XLn5ojsknkw4V6Mx+EySDo+pqysAZBMwcJ\nu606o35AoRhJyd6QE4iVif4QoASaDvd2uK7yYRrk0lB5+vRIob3/uksXRwjLnIIk\nWtSe5gO4PuxzMtPaxTC/0KzXXO5jRFadVO9mTjOiDdZUd2dgGHnoZY8cuDSNcbDm\n4exiZHtxIT+6j6tsQ8WjxTDTpFtiKQDQWfh3k3xaRMLlLwfZt83a1QLzrz6Yf6cb\nPLz3RJTTrvzDJFCGGvRw1HphItV0dhP+6eXgVyCoP2r12dKpB08j1Ikk12kA/IWt\n6QDE/v/BvLxZljivkCflBskn1q9FtV2sEX9krKNDmgY=\n-----END CERTIFICATE-----\n",
      )
    end
  end
end
