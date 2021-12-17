Rails.application.routes.draw do
  
  get '/asana', to: 'asanas#index'
  get '/taskkpi', to: 'asanas#kpi'
  get '/asanaapitest', to: 'asanaapi#ramen01'
  post '/asanaapitest', to: 'asanaapi#ramen01'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  get 'landing/home'
  root 'landing#home'

  # kentei 
  get '/kentei', to: 'kentei#index'
  get '/siken', to: 'kentei#siken'
  resources :kmondais
  get '/kmondaiexcel', to: 'kmondais#newexcel'
  post '/kmondaiexcel', to: 'kmondais#kentei_excel'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
