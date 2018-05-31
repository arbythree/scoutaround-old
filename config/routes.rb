Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :requirements

  resources :units do
    resources :memberships, path: 'members' do
      resources :achievements, path: 'advancement'
    end
    resources :achievements, path: 'advancement'
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
  resources :status
end
