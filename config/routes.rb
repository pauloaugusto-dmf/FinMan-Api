Rails.application.routes.draw do
  
  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }

  namespace :api, defaults: { format: :json } do
    resources :accounts do
      post 'transaction', to: 'transactions#create'
      get 'transaction/:id', to: 'transactions#show'
      get 'transaction', to: 'transactions#index'
      patch 'transaction/:id', to: 'transactions#update'
      put 'transaction/:id', to: 'transactions#update'
      delete 'transaction/:id', to: 'transactions#destroy'
    end
  end
end
