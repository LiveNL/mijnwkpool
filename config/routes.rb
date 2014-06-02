Wkpool::Application.routes.draw do
  scope '/app' do
    get 'users/welcome' => 'users#welcome', :as => 'welcome'
    get 'pools/:id/invite' => 'pools#invite', :as => 'invite_pool'
    post 'create_multiple_predictions', to: 'predictions#create_multiple_predictions'
    patch 'update_multiple_predictions', to: 'predictions#update_multiple_predictions'
    get 'pouleeindstanden/:id' => 'predictions#pouleeindstanden', :as => 'pouleeindstanden'
    get 'knockoutfase/:id' => 'predictions#knockoutfase', :as => 'knockoutfase'
    get 'bonusvragen/:id' => 'predictions#bonusvragen', :as => 'bonusvragen'
    resources :pools, :users, :poolmemberships, :predictions, :teampredictions
    post 'create_multiple_predictions', to: 'predictions#create_multiple_predictions'
    get 'givepoints' => 'predictions#givepoints', :as => 'givepoints'
    get 'givepoints1' => 'predictions#givepoints1', :as => 'givepoints1'
    get 'bier' => 'predictions#bier', :as => 'bier'
    get 'pointsscript' => 'predictions#pointsscript', :as => 'pointsscript'
    get 'pointsscript2' => 'predictions#pointsscript2', :as => 'pointsscript2'
    get 'speluitleg' => 'pages#speluitleg', :as => 'speluitleg'
    resources :games do
      member do
        patch :toggle
      end
    end
    resources :teams do
      member do
        patch :toggle
      end
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets

  get 'logout' => 'sessions#destroy', :as => 'log_out'
  get 'login' => 'sessions#new', :as => 'log_in'
  get 'register' => 'users#new', :as => 'register'

  get 'app' => 'users#dashboard', :as => 'app_root'

  root  'pages#home'

  get 'ping' => proc { |env| [200, {}, ['pong']] }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
