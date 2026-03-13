Rails.application.routes.draw do
  get "notification_settings/edit"
  get "notification_settings/update"
  get "notifications/index"
  get "accounts/show"
  get "accounts/update"
  get "static_pages/terms"
  get "static_pages/privacy"
  get "couple_settings/show"
  get "couple_settings/update"
  get "settings/show"
  get "tags/new"
  root "home#index"
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  devise_scope :user do
    get "users/edit_email", to: "users/registrations#edit_email", as: :edit_user_email
  end
  # 招待コード発行
  get "invitations/new"
  # 招待コード参加（追加）
  get  "invitations/use", to: "invitations#use_form"
  post "invitations/use", to: "invitations#use"
  # ===== Static Help Pages =====
  get "/about", to: "static_pages#about"
  get "/how_to_use", to: "static_pages#how_to_use"
  get "/faq", to: "static_pages#faq"
  get "/terms",   to: "static_pages#terms"
  get "/privacy", to: "static_pages#privacy"
  get "/support", to: "static_pages#support"
  namespace :couples do
    get "onboarding", to: "onboarding#choice"
  end

  resources :invitations, only: [ :new, :create ]
  resources :moods, only: [ :create, :index ]
  resources :thanks, only: [ :new, :create, :index ]
  resources :tags, only: [ :new, :create ] do
    member do
      post :toggle_visibility
    end
  end
  resources :notifications, only: [ :index ] do
    collection do
      patch :mark_all_as_read
    end
  end
  resource :settings, only: [ :show ]
  resource :couple_settings, only: [ :show, :update ] do
    delete :destroy
  end
  resource :account, only: [ :show, :update ]
  resource :notification_settings, only: [ :edit, :update ]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
