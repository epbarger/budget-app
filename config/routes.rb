Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'budgets#index'

  resources :budgets do
    resources :budget_cycles do 
      resources :balance_events, only: [:create, :show]
    end
  end
end
