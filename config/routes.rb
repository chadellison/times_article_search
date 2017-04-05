Rails.application.routes.draw do
  root to: "search#index"
  resources :search, only: [:index, :create]
end
