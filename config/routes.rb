Rails.application.routes.draw do

  get 'homes/index'
  mount Ckeditor::Engine => '/ckeditor'

  resources :users do
    member do

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
end
