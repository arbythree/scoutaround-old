Rails.application.routes.draw do
  mount PdfjsViewer::Rails::Engine => "/pdfjs", as: 'pdfjs'
  devise_for :users
  root to: 'home#index'
  resources :submissions

  resources :events do
    get 'info'
    resources :submissions
  end

  resources :event_registrations do
    resources :event_requirements do
      resources :submissions
    end
  end

  get 'units/:unit_id/members/roster', to: 'members#roster'
  get 'units/:unit_id/events/:event_id/info', to: 'events#info', as: 'unit_event_info'

  resources :units do
    resources :members
    resources :events
  end

  resources :members
end
