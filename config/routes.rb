Rails.application.routes.draw do
  resources :departments
  resources :groups
  resources :job_titles
  resources :members
  resources :projects
  resources :projects_members_mothly_allocations
  resources :projects_monthly_allocations
  root "members#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
