Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :submissions

  resources :events do
    get 'info'
    resources :submissions
  end

  resources :registrations do
    resources :event_requirements do
      resources :submissions
    end
  end

  resources :units do
    resources :members
  end

  resources :members
end
