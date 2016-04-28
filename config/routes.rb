Rails.application.routes.draw do

  resources :order_details
  resources :orders
  resources :groups
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }


resources :orders do 

	resources :order_details
 end

 
  get 'searchfriend', to: 'friend#search_friend'
  post 'addfriend', to: 'friend#addFriend'
  delete 'unfriend', to: 'friend#unFriend'
  get 'mygroups', to: 'groups#index'
  get "group_members", to: 'groups#group_members'
  post "addFriendsToGroup", to: 'groups#addFriendsToGroup'
  # get ':groups/:group_members/:id'
  # get '/friend/:id/addFriend', to:'friend#addFriend', as: 'addfriend' 
  #   get '/friend/:id/search_friend', to:'friend#search_friend', as: 'searchfriend'
  # delete '/friend/:id/unFriend', to: 'friend#unFriend', as: 'unfriend'


    get "myfriends", to: 'friend#my_friends'
    # get "addfriends/:id", to: 'friend#addFriends/:id'
    # get "myfriends/:id", to: 'friend#unFriends/:id'



    # get '/sign_in', to: 'users#sign_in'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'orders#index'
    # match 'sessions#create'
  get 'signin', to: 'sessions#new', as: 'signin'

  # Example of regular route:
    # get 'products/:id' => 'catalog#view'

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
