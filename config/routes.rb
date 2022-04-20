Rails.application.routes.draw do
  resources :classification_names
  resources :order_names
  resources :system_names
  # kentei API
  get '/randomexam', to: 'kenteiapis#randomexam'

  # asana API
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

  #get '/tasksinsection', to: 'asanaapi#tasksinsection'
  post '/tasksinsection', to: 'asanaapi#tasksinsection'
  get '/jissekitasks', to: 'asanaapi#jissekitasks'

  #get '/tasksinproject', to: 'asanaapi#tasksinproject'
  post '/tasksinproject', to: 'asanaapi#tasksinproject'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  #devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  #devise_scope :user do
  #  get 'users/sign_in', to: 'users/sessions#new', as: :new_user_session
  #  get 'users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
  #end

  get 'landing/home'
  root 'landing#home'

  # kentei 
  get '/kentei', to: 'kentei#index'
  get '/siken', to: 'kentei#siken'
  get '/sikenindex', to: 'kentei#sikenindex'
  get '/shinkishiken', to: 'kentei#shinkishiken'
  get '/shikenkanri', to: 'kentei#shikenkanri'
  post '/newtest', to: 'kentei#createtest'
  post '/choosemondai', to: 'kentei#choosemondai'
  resources :kmondais
  get '/kmondaiexcel', to: 'kmondais#newexcel'
  post '/kmondaiexcel', to: 'kmondais#kentei_excel'
  post '/kenteianswer', to: 'kentei#dailyanswer'

  post '/kentei_changedate', to: 'kentei#kentei_changedate'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
