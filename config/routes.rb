Rails.application.routes.draw do
  resource :address_search, only: %i[new create]
  resource :address, only: [:create]
  resources :appointments, only: [:new]

  namespace :questions do
    get '/start', to: 'start#index', as: 'start'
    post '/start', to: 'start#submit', as: 'start_submit'

    get '/repair-type', to: 'repair_type#index', as: 'repair_type'
    post '/repair-type', to: 'repair_type#submit', as: 'repair_type_submit'
  end

  get '/emergency-contact',
      to: 'pages#emergency_contact',
      as: 'emergency_contact'

  root to: 'start#index'
end
