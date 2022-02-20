Rails.application.routes.draw do
  root 'static_pages#top'

  namespace :admin do
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :events, only: %i[index edit update show destroy]
    resources :users, only: %i[index edit update show destroy]
  end
end
