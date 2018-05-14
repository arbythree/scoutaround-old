Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :events do
    get 'info'
    resources :submissions
  end
  resources :submissions
  resources :registrations do
    resources :event_requirements do
      resources :submissions
    end
  end
end
