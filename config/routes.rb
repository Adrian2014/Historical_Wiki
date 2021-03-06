Rails.application.routes.draw do
  get 'users/new' => 'users#new'
  get 'users/show' => 'users#show'
  post 'users/create' => 'users#create'
  get 'users/login' => 'users#login'
  post 'users/login' => 'users#login_post'
  get 'users/show' => 'users#show'
  get 'users/logout' => 'users#logout'
  get 'users/welcome' => 'users#welcome'

  post 'tags/search' => 'tags#search'

  get 'posts/getdata' => 'posts#get_data'
  get 'posts/data' => 'posts#data'
  get 'posts/year/:year' => 'posts#posts_by_year'

  resources :posts do
    resources :comments, only: [:new, :create]
  end
  # get 'posts/:id/comments/new' => 'comments#new'
  # post 'posts/:id/comments/new' => 'comments#create'

  resources :tags, only: [:show]

  resources :images, only: [:show]

  resources :posts

  root 'posts#index'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #

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
