Rails.application.routes.draw do
  resources :projects_monthly_allocations
  resources :groups
  resources :departments
  resources :projects
  resources :members
  root "members#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
