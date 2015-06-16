Rails.application.routes.draw do

  root 'static_page#home'

  get '/lang/:lang', to: 'application#set_lang', as: 'set_lang'

  get '/login', to: 'users#login'
  post '/login', to: 'users#login_auth'
  get '/logout', to: 'users#logout'
  get '/registration', to: 'users#registration'
  post '/registration', to: 'users#registration_auth'

end
