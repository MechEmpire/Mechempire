Rails.application.routes.draw do
  resources :matches

  # get 'battles/index'

  # get 'battles/new'

  # get 'battles/create'

  # get 'battles/destroy'

  # get 'battles/edit'

  # get 'battles/update'

  # get 'weapons/index'

  # get 'weapons/show'

  # get 'weapons/create'

  # get 'weapons/edit'

  # get 'weapons/destroy'

  # get 'carriers/index'

  # get 'carriers/show'

  # get 'carriers/create'

  # get 'carriers/edit'

  # get 'carriers/destroy'

  root 'home#index'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :meches
  resources :carriers
  resources :weapons
  resources :battles

  match '/signup',  to: 'users#new', via: 'get'
  match '/signin',  to: 'sessions#new', via: 'get'
  match '/signout',  to: 'sessions#destory', via: 'delete'
  match '/active', to: 'users#active', via: 'get'
  match '/about', to: 'home#about', via: 'get'
  match '/aboutus', to:'home#aboutus',via: 'get'
  match '/join', to: 'home#join', via: 'get'
  match '/achieve', to: 'home#achieve', via: 'get'
  match '/mechlist', to: 'meches#mech_list', via: 'get'
  match '/reactive', to: 'users#re_active',via: 'get'
  match '/following/:followed_id', to: 'users#following',via: 'post', as: :follow_user
  match '/unfollowing/:unfollowed_id', to: 'users#unfollowing', via: 'post', as: :unfollow_user
  match '/battle/:defender_id/:attacker_id', to: 'battles#create', via: 'get'
  # match '/admin', to: 'users#admin', via: 'get'

  # match '/setting'
  
  # resources :users do
  #   member do
  #     get 'index', 'edit', 'destory', 'new'
  #   end
  # end
  # get 'home/index'

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