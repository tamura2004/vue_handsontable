Rails.application.routes.draw do
  resources :costs
  resources :works
  get "init_works", to: "works#seed"

  resources :groups_projects

  resources :groups,except:[:new,:edit] do
    resources :works
    resources :costs
  end

  resources :departments , except: [:new,:edit]
  resources :job_titles  , except: [:new,:edit]

  resources :members_projects_months , except: [:new,:edit]
  resources :members_months          , except: [:new,:edit]

  resources :members, except: [:new,:edit] do
    resources :assignments, except: [:new,:edit], controller: :projects_members
    resources :members_projects_months, except: [:new,:edit]
    resources :members_months, except: [:new,:edit]
  end

  resources :projects, except: [:new,:edit] do
    resources :assignments, except: [:new,:edit], controller: :projects_members
    resources :members_allocations, except: [:new,:edit], controller: :projects_members_months
    resources :allocations, except: [:new,:edit], controller: :projects_monthly_allocations
  end

  resources :projects_allocations, except: [:new,:edit], controller: :projects_monthly_allocations
  root "projects_monthly_allocations#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
