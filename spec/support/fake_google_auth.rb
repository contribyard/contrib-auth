require 'sinatra/base'

class FakeGoogleAuth < Sinatra::Base
  post '/v1/accounts:signInWithPassword' do
    json_response 200, 'sign_in_with_password.json'
  end

  post '/v1/accounts:signUp' do
    json_response 200, 'sign_up.json'
  end

  post '/v1/accounts:accounts:sendOobCode' do
    json_response 200, 'reset_password.json'
  end

  post '/v1/accounts:update' do
    json_response 200, 'change_password.json'
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end
end
