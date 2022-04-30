Rails.application.routes.draw do
  resources :accounts
  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }

  namespace :api, defaults: { format: :json } do
    resources :accounts
  end
end
