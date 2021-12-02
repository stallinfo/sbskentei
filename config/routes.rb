Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get 'landing/home'
  root 'landing#home'

  # kentei 
  get '/kentei', to: 'kentei#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
