Rails.application.routes.draw do
  get 'landing/home'
  root 'landing#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
