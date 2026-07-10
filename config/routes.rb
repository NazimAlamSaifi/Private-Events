Rails.application.routes.draw do
  devise_for :users
  resources :events
  resources :users, only: [ :show ]

  # Update this line to include :destroy
  resources :event_attendances, only: [ :create, :destroy ]

  root "events#index"
end
