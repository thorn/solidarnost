Solidarnost::Application.routes.draw do

  match 'statistics' => 'statistics#index', as: 'statistics'
  match 'statistics/show' => 'statistics#show', as: 'statistic'

  get "pages/home"

  get "pages/about"

  resources :families do
    collection do
      match :search
    end
    member do
      match :persist
    end
  end
  resources :visits do
    post :search, on: :collection
    get  :search, on: :collection
  end
  resources :family_helps do
    collection do
      post :search
      get :search
      post :help_search
      get :help_search
    end
  end

  resources :users_families
  resources :family_necessities, :only => [:destroy]
  devise_for :users

  namespace :admin do
    root :to => "users#index"
    resources :users
    resources :cities do
      get :get_new, on: :collection
    end
    resources :groups
    resources :group_options
    resources :help_types
    resources :necessities
    resources :study_categories
    resources :roles
    resources :funds
    resources :settings
    resources :areas
    resources :news do
      member do
        get :mark_as_read
      end
    end
  end

  resources :children
  resources :trusties
  resources :mothers
  resources :fathers
  resources :family_members

  match '/delete_multiple' => "pages#delete_multiple", as: :delete_multiple
  match '/read_multiple'   => "pages#read_multiple",   as: :read_multiple

  root to: 'families#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', as: :purchase
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
