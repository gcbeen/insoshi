# -*- encoding : utf-8 -*-
Insoshi::Application.routes.draw do
  devise_for :users,  controllers: { omniauth_callbacks: "omniauth_callbacks" }

  #resources :follows
  resources :items
  
  resources :photoes
  #resource :user_session
  resources :users do #, :constraints => { :id => /[0-9]+/ } do
   member  do
     get 'change_info'
     get 'profile'
     put 'change_info'
   end
    resources :follows, :only => [:create, :destroy] #, :only => [:index, :show]
	resources :blogs
	resources :topics
	resources :comments
	resources :favorites
  end

  resources :blogs, :comments do
	resources :users do
	  resources :comments do
		member do
		  post 'change'
		end
	  end
	end

    member do
      put 'like_it'
	  put 'favorite'
	  post 'reply'
    end
  end

  resources :topics, :comments do
	resources :users do
	  resources :comments do
		member do
		  post 'modify'
		end
	  end
	end

    member do
      put 'like_it'
	  put 'favorite'
	  post 'reply'
    end
  end

  #resource :account, :controller => "users"
  #resources :users
  #
  #match '/users/sign_in' => 'user_sessions#new', :as => :login
  #match 'logout' => 'user_sessions#destroy', :as => :logout
  #match 'register' => 'users#new', :as => :register

  #match '/auth/:provider/callback' => 'user_oauth#create', :as => :callback
  #match '/auth/failure' => 'user_oauth#failure', :as => :failure
  #
  #match '/auth/facebook' => 'user_oauth#create', :as => :fb_login
  #match '/auth/twitter' => 'user_oauth#create', :as => :tw_login

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end