Rails.application.routes.draw do
  devise_for :users, controllers: { invitations: 'users/invitations' }
  root to: 'home#index'

  resources :requirements

  match '/payment_setup', to: 'stripe#payment_setup', as: 'payment_setup', via: [:get]

  resources :units do
    resources :membership_imports

    resources :memberships, path: 'members' do
      resources :achievements, path: 'advancement'
    end
    resources :achievements, path: 'advancement', controller: :unit_achievements
    resources :document_library_items, path: 'documents'
    resources :events do
      resources :messages
      resources :event_registrations, path: 'registrations'
      resources :event_submissions,   path: 'submissions'
      resources :event_requirements,  path: 'checklist' do
        resources :event_submissions, path: 'submissions'
      end
      resources :messages
    end
  end

  resources :members
  resources :status
end
