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
    resources :customers, only: [:index, :show, :edit, :update]
  end
  namespace :admins do
    resources :posts, only: [:index, :show]
  end
  namespace :admins do
    root to: "homes#top"
  end
  namespace :public do
    resources :customers, only: [:show, :edit, :update] do
      collection do
        get :confirm
        patch :withdraw
      end
    end
    get 'customers/confirm'
    #patch 'customers' => 'customers#withdraw', as: 'withdraw'
  end
  namespace :public do
    resources :relationships, only: [:create, :destroy, :followings, :followers]
  end
  namespace :public do
    resources :searches, only: [:search]
  end
  namespace :public do
    resources :favorites, only: [:index, :create, :destroy]
  end
  namespace :public do
    resources :comments, only: [:create]
  end
  namespace :public do
    resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy]
  end
  namespace :public do
    root to: "homes#top"
    get 'homes/about', as: 'about'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end