Rails.application.routes.draw do
root 'welcome#index'
  get "/auth/:provider/callback", to: "sessions#create", as: "signin"
  get 'signout', to: 'sessions#destroy', as: "signout"
  get '/attractions', to: 'attractions#index', as: "attractions"
  # get 'auth/failure', to: redirect('/')  -- think of a route here
  get '/search', to: 'search#index'
  get '/search_suggestions', to: 'search#autocomplete'
  resources :users
  get "/profile" => "users#show", as: :profile
  get "/users" => "users#index"
  resources :crimes
  resources :corrals do
    resources :reviews
    get '/checkin', to: 'checkins#create', as: "checkins"
    get '/checkout', to: 'checkins#destroy', as: "checkouts"
  end




  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:

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
