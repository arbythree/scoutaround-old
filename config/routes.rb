Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :messages

  resources :events do
    resources :event_registrations, path: 'registrations'
  end

  # resources :event_registrations do
  #   resources :event_requirements do
  #     resources :submissions
  #   end
  # end

  resources :units do
    resources :memberships, path: 'members'
    resources :document_library_items, path: 'documents'
    resources :events do
      resources :event_registrations, path: 'registrations'
      resources :event_submissions,   path: 'submissions'
      resources :event_requirements,  path: 'checklist'
      resources :messages
    end
  end

  resources :members
end
