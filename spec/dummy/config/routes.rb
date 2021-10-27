Rails.application.routes.draw do
  mount Contrib::Auth::Engine => "/auth"
end
