Rails.application.routes.draw do
  resource :address_search, only: %i[new create]
  resource :address, only: [:create]
  resources :appointments, only: [:new]

  namespace :questions do
    get '/start', to: 'start#index', as: 'start'
    post '/start', to: 'start#submit', as: 'start_submit'

    get '/repair-type', to: 'repair_type#index', as: 'repair_type'
    post '/repair-type', to: 'repair_type#submit', as: 'repair_type_submit'

    get '/door-material', to: 'door_material#index', as: 'door_material'
    post '/door-material', to: 'door_material#submit', as: 'door_material_submit'

    get '/door-location', to: 'door_location#index', as: 'door_location'
    post '/door-location', to: 'door_location#submit', as: 'door_location_submit'

    get '/bath-rising', to: 'bath_water_rising#index', as: 'bath_water_rising'
    post '/bath-rising', to: 'bath_water_rising#submit', as: 'bath_water_rising_submit'

    get '/describe-repair', to: 'describe_repair#index', as: 'describe_repair'
    post '/describe-repair', to: 'describe_repair#submit', as: 'describe_repair_submit'
  end

  get '/emergency-contact',
      to: 'pages#emergency_contact',
      as: 'emergency_contact'

  root to: 'start#index'
end
