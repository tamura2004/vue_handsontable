Rails.application.routes.draw do
  resources :members_projects_months
  resources :members_months
  resources :projects_members
  resources :departments
  resources :groups
  resources :job_titles

  resources :members do
    resources :members_projects_months
    resources :members_months
  end

  resources :projects do
    resources :projects_members_months
    resources :projects_monthly_allocations
  end
  resources :projects_monthly_allocations
  root "projects_monthly_allocations#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
