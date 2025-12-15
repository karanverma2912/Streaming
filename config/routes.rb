Rails.application.routes.draw do
  # API Namespace
  # namespace :api do
  #   namespace :v1 do
  #     resources :series
  #     resources :episodes
  #   end
  # end
  resources :users
  resource :series
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
