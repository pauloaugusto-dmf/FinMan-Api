Rails.application.routes.draw do
  
  devise_for :users,
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  namespace :api, defaults: { format: :json } do
    resources :accounts do
      resources :transactions
    end
    resources :checking_accounts
    resources :tags
    resources :incomes
    resources :debts
  end
end
