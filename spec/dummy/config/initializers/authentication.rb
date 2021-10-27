Contrib::Auth.configure do |config|
  config.provider = Contrib::Auth::Provider::GoogleAuth.new('api_key')
end
