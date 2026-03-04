Rails.application.routes.draw do
  devise_for :users
  root "products#index"
  resources :products, only: [ :index, :show ] # /products
  get "cart",                       to: "cart#show", as: :cart # /cart
  post "cart/add/:variant_id",      to: "cart#add", as: :add_to_cart # / cart/add/:variant_id
  delete "cart/remove/:variant_id", to: "cart#remove_item", as: :remove_from_cart # /cart/remove/:variant_id
  delete "cart/clear",              to: "cart#clear", as: :clear_cart # /cart/clear

  namespace :admin do
    root to: "dashboard#index"  # /admin
    resources :products # /admin/products
    resources :branches # /admin/branches
    resources :warehouses
    resources :users
    resources :metrics
    resources :orders, only: [ :index, :show, :destroy ] # /admin/orders
  end

  namespace :customer do
    root to: "profile#index"  # /customer
    resources :orders, only: [ :index, :show, :new, :create, :update ] # /customer/orders
    get "settings" => "profile#settings"
  end

  namespace :inventory do
    root to: "dashboard#index"  # /inventory
    resources :products do # /inventory/products
      resources :product_variants do # /inventory/products/:product_id/product_variants
        resources :inventories, only: [ :new, :create, :edit, :update, :index ] # /inventory/products/:product_id/product_variants/:product_variant_id/inventories
      end
    end
    resources :branches, only: [ :index, :show, :update, :edit ] # /inventory/branches
    resources :warehouses, only: [ :index, :new, :create, :edit, :update ] # /inventory/warehouses
    resources :orders, only: [ :index, :show, :update ] do
    collection do
      get :all   # Esto crea la ruta /inventory/orders/all
    end
    end
    get "total" => "inventory#total"

    resources :analytics, only: [ :index ] # /inventory/analytics
  end

  namespace :warehouse do
    root to: "dashboard#index"  # /warehouse
    resources :orders, only: [ :show, :update ] # /warehouse/orders
  end

  namespace :branch do
    root to: "dashboard#index"  # /store
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
