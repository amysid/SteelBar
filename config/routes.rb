Rails.application.routes.draw do

  get 'suppliers/index'
  get 'suppliers/new'
  get 'length_edges/new'
  get 'length_edges/index'
  get 'length_edges/show'
  get 'general_panels/new'
  get 'general_panels/create'
  get 'general_panels/index'
  get 'customer_panels/new'
  get 'customer_panels/create'
  get 'customer_panels/index'
  get 'enquiries/new'
  get 'enquiries/create'
  get 'enquiries/index'
  # get 'staffs/index'
  get 'homes/index'
  mount Ckeditor::Engine => '/ckeditor'
  resources :staffs do
    member do
      get :change_status
    end
     collection do
      post :import
    end
  end
  resources :users do
    member do

    end
  end
  resources :customer_panels do
    collection do
      # get :new_details
      get :edit_details
      post :create_details
      put :details_update
      post :import

    end
    member do
      get :new_details
    end

  end
  resources :price_lists do
    collection do
     post :import
     get :pricelistsample
    end
  end
  resources :basic_prices
  resources :suppliers

  resources :general_panels

  resources :length_edges do
     collection do
     post :import
    end
  end
  resources :surfaces do
    collection do
     post :import
    end
  end
  resources :coatings do
    collection do
     post :import
    end
  end
  resources :pods do
    collection do
     post :import
    end
  end
  resources :custom_premiums do
    collection do
     post :import
    end
  end

  resources :enquiries do
    collection do
     post :import
     get :calculate
    end
  end
  resources :homes do
    collection do

    end
  end
  root 'homes#index'

  get 'login',to: 'sessions#new'
  post 'create',to: 'sessions#create'
  get 'forgot_password',to: 'sessions#forgot_password'
  post 'send_link',to: 'sessions#send_link'
  post 'change_password',to: 'sessions#change_password'
  get 'logout',to: 'sessions#destroy'
  get 'profile', to: "sessions#profile"
  post 'update_profile',to: 'sessions#update_profile'
end
