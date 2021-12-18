Rails.application.routes.draw do
  
  get '/asana', to: 'asanas#index'
  get '/taskkpi', to: 'asanas#kpi'
  get '/asanaapitest', to: 'asanaapi#ramen01'
  post '/asanaapitest', to: 'asanaapi#ramen01'
  get '/asanateamlist', to: 'asanaapi#teamlist'
  post '/asanateamlist', to: 'asanaapi#teamlist'
  get '/asanaprojectlist', to: 'asanaapi#projectlist'
  #post '/asanaprojectlist', to: 'asanaapi#projectlist'
  get '/asana_project', to: 'asanaapi#project'
  get '/asanacreatetask', to: 'asanaapi#create_task_01'
  post '/asanacreatetask', to: 'asanaapi#create_task_01'

  get '/user', to: 'asanaapi#pv_user'
  get '/tasks', to: 'asanaapi#pv_tasks'
  get '/task', to: 'asanaapi#pv_task'
  get '/subtasks', to: 'asanaapi#pv_subtasks'
  get '/section', to: 'asanaapi#pv_section'

  get '/taskinsection', to: 'asanaapi#taskinsection'


  
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
