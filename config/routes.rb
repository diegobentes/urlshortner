Rails.application.routes.draw do

  resources :urls
  resources :users, param: :_username
  
  post '/auth/login', to: 'authentication#login'
  get '/*short_url', to: 'application#redirection'
  
end
