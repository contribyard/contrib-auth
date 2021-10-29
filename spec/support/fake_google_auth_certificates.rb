require 'sinatra/base'

class FakeGoogleAuthCertificates < Sinatra::Base
  get '/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com' do
    json_response 200, 'certificates.json'
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end
end
