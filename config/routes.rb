Umvox::Application.routes.draw do

  devise_for :users, :controllers => {:registrations => 'registrations',:sessions => 'sessions'} do
    
  end

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  root :to => "members#dashboard"
  
  get '/terms', :to =>"welcome#terms"
  resources :email_stats
  
  resources :company_emails

  resources :email do
    collection do
      post :sendmail
      get :view
    end
  end

 resources :welcome do
   collection do
    post  :login
    get  :callback, :howitworks
   end
 end

  resources :locations do
    collection do
      get :search
      post :search
    end
  end
 resources :posts do
   collection do
     get :search,:browse,:list, :next
     post :browse
   end
   resources :comments
 end   
  resources :members do
  collection do
    get   :filldetails,:dashboard,:signin,:contactus,:userp
    put  :updateprofile, :support
    post  :updateprofile,:support
  end
end
#  resources :assets

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
