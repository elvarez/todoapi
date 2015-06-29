Rails.application.routes.draw do

  resources :users do
    resources :lists
  end

  resources :lists do
    resources :items 
  end

  namespace :api, defaults: { format: :json } do
    resources :users do
      resources :lists
    end

    resources :lists, only: [] do
      resources :items, only: [:create]
    end

    resources :items, only: [:destroy, :update]
    
  end

  
end
