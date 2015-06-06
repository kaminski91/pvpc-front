Rails.application.routes.draw do

  root 'static_page#home'

  get '/login', to: 'users#login'
  post '/login', to: 'users#login_auth'
  get '/registration', to: 'users#registration'
  post '/registration', to: 'users#registration_auth'

end
