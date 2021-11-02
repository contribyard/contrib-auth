Contrib::Auth::Engine.routes.draw do
  defaults format: :json do
    post '/sign_in_with_password' => 'authentication#sign_in_with_password'
    post '/reset_password'        => 'authentication#reset_password'
    post '/change_password'       => 'authentication#change_password'
    get  '/certificates'          => 'authentication#certificates'
    post '/sign_up_with_email_or_username_and_password' => 'authentication#sign_up_with_email_or_username_and_password'
  end
end
