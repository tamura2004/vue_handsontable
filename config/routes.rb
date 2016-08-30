Rails.application.routes.draw do
  namespace :project do
    get 'assigns/index'
  end

  resources :costs
  resources :works
  get "init_works", to: "works#seed"

  resources :groups_projects

  resources :groups,except:[:new,:edit] do
    resources :works
    resources :costs
    resources :job_titles, only: :index do
      resources :assigns, controller: "group/job_title/assigns", only: :index
    end
  end

  resources :departments , except: [:new,:edit]
  resources :job_titles  , except: [:new,:edit]

  resources :members_projects_months , except: [:new,:edit]
  resources :members_months          , except: [:new,:edit] do
    collection do
      get :ags
    end
  end

  resources :members, except: [:new,:edit] do

    resources :assigns, controller: "member/assigns", only: :index

    resources :assignments, except: [:new,:edit], controller: :projects_members
    resources :members_projects_months, except: [:new,:edit]
    resources :members_months, except: [:new,:edit]
  end

  resources :projects, except: [:new,:edit] do

    resources :assigns, controller: "project/assigns", only: :index

    resources :assignments, except: [:new,:edit], controller: :projects_members
    resources :members_allocations, except: [:new,:edit], controller: :projects_members_months
    resources :allocations, except: [:new,:edit], controller: :projects_monthly_allocations
  end

  resources :projects_allocations, except: [:new,:edit], controller: :projects_monthly_allocations do
    collection do
      get :ags
    end
  end

  get :ags, to: "ags#index"

  root "projects_monthly_allocations#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
