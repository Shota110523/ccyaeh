Rails.application.routes.draw do
  root to: "public/homes#top"

  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admins/sessions",
    ragistrations: "admins/registrations"
  }
  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
  passwords: 'public/passwords'
  }
  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  namespace :admins do
    resources :customers, only: [:index, :show, :edit, :update, :destroy] do
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      member do
        get :favorites
      end
    end
  end
  namespace :admins do
    resources :posts, only: [:index, :show] do
      get "customer", to: "favorites#customer"
    end
  end
  namespace :admins do
    get "search" => "searches#search"
  end
  namespace :public do
    resources :customers, :only => [:show, :edit, :update, :destroy] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      member do
        get :favorites
      end
      collection do
        get :confirm
        patch 'release/:customer_id' => 'customers#release', as: 'release'
        patch 'nonrelease/:customer_id' => 'customers#nonrelease', as: 'nonrelease'
      end
    end
    get 'customers/confirm'
    #patch 'customers' => 'customers#withdraw', as: 'withdraw'
  end
  namespace :public do
    resources :relationships, only: [:create, :destroy, :followings, :followers]
  end
  namespace :public do
    get "search" => "searches#search"
  end
  namespace :public do
    resources :favorites, only: [:index, :create, :destroy]
  end
  namespace :public do
    resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
      get "customer", to: "favorites#customer"
    end
  end
  namespace :public do
    resources :notifications, only: [:index] do
      delete "destroy_all", to: "notifications#destroy_all"
    end
  end
  namespace :public do
    root to: "homes#top"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end