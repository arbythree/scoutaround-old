Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :requirements

  match '/payment_setup', to: 'stripe#payment_setup', as: 'payment_setup', via: [:get]

  resources :units, shallow: true do
    resources :membership_imports
    resources :events
    resources :memberships, path: 'members'
    resources :achievements, path: 'advancement', controller: :unit_achievements
    resources :document_library_items, path: 'documents'
  end

  resources :memberships, path: 'members', shallow: true do
    resources :achievements, path: 'advancement'
  end

  resources :events, shallow: true do
    resources :messages
    resources :event_registrations, path: 'registrations'
    resources :event_submissions,   path: 'submissions'
    resources :event_requirements,  path: 'checklist'
  end

  resources :event_requirements, path: 'checklist', shallow: true do
    resources :event_submissions, path: 'submit'
  end

  resources :event_submissions, path: 'submit'

  resources :event_registrations

  resources :members
  resources :status
end
