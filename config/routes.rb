Rails.application.routes.draw do
  
 get '/histories/index', to: 'histories#index'
  
  get 'sessions/new'
  get 'users/new'
  get 'pages/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root "pages#index"
  resources :users

  get    '/login', to: 'sessions#new'
  post   '/login', to: "sessions#create"
  delete '/logout',to: 'sessions#destroy'
  
  get  '/histories',   to:'histories#new'
  
                        
  post '/histories',   to:'histories#create'
  delete '/histories', to:'histories#destroy'
  
  
end
