Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :units do
    resources :memberships, path: 'members'
    resources :document_library_items, path: 'documents'
    resources :events do
      resources :messages
      resources :event_registrations, path: 'registrations'
      resources :event_submissions,   path: 'submissions'
      resources :event_requirements,  path: 'checklist'
      resources :messages
    end
  end

  resources :members
end
