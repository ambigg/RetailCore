Rails.application.routes.draw do
  devise_for :users
  root "products#index"
  resources :products, only: [ :index, :show ]
  # resources :cart, only: [ :show, :update, :destroy ]

  namespace :admin do
    root to: "dashboard#index"  # /admin
    resources :branches
    resources :warehouses
    resources :users
    resources :metrics
  end

  namespace :customer do
    root to: "profile#index"  # /customer
    get "settings" => "profile#settings"
  end

  namespace :inventory do
    root to: "home#index"  # /inventory
    resources :products do
      resources :product_variants
    end
    get "analytics" => "analytics#index"
  end

  namespace :warehouse do
    root to: "orders#index"  # /warehouse
  end

  namespace :branch do
    root to: "sales#index"  # /store
  end





  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
end
