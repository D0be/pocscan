Rails.application.routes.draw do
  get 'portscans/index'

  root 'welcome#index'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/newvul', to: 'vuls#new'
  post '/newvul', to: 'vuls#create'
  get 'search/index'
  get 'search', to: 'search#index'
  resources :users
  resources :vuls
  resources :portscans
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
