Rails.application.routes.draw do
  mount PdfjsViewer::Rails::Engine => "/pdfjs", as: 'pdfjs'
  devise_for :users
  root to: 'home#index'
  resources :submissions

  resources :events do
    resources :event_registrations, path: 'registrations'
    resources :event_submissions
    resources :submissions
  end

  resources :event_registrations do
    resources :event_requirements do
      resources :submissions
    end
  end

  resources :units do
    resources :memberships, path: 'members'
    resources :events
  end

  resources :members
end
