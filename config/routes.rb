Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :requirements

  match '/payment_setup', to: 'stripe#payment_setup', as: 'payment_setup', via: [:get]

  resources :users, only: [:show, :edit, :update]

  resources :units, shallow: true do
    scope module: 'units' do
      resources :membership_imports
      resources :events
      resources :memberships, path: 'members'
      resources :achievements, path: 'advancement'
      resources :document_library_items, path: 'documents'
      resources :wiki_articles, path: 'wiki'
    end
  end

  resources :memberships, path: 'members', shallow: true do
    scope module: 'memberships' do
      resources :achievements, path: 'advancement'
    end
  end

  resources :events, shallow: true do
    scope module: 'events' do
      resources :messages
      resources :event_registrations, path: 'registrations'
      resources :event_submissions,   path: 'submissions'
      resources :event_requirements,  path: 'checklist'
    end
  end

  resources :event_requirements, path: 'checklist', shallow: true do
    scope module: 'event_requirements' do
      resources :event_submissions, path: 'submit'
    end
  end

  # resources :event_submissions, path: 'submit'
  # resources :event_registrations

  resources :members
  resources :status
end
