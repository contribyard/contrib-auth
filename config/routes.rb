Contrib::Auth::Engine.routes.draw do
  defaults format: :json do
    post '/sign_in_with_password' => 'authentication#sign_in_with_password'
  end
end
