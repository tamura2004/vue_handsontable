Rails.application.routes.draw do

  root "costs#index", group_id: 1

  resources :departments             , except: [:new,:edit]
  resources :job_titles              , except: [:new,:edit]
  # resources :costs                   , except: [:new,:edit]
  # resources :works                   , except: [:new,:edit]
  # resources :groups_projects

  resources :results, only: [:index,:destroy] do
    collection do
      post :upload
    end
  end

  # namespace :members do
  #   get 'projects/index'
  # end

  # namespace :project do
  #   get 'assigns/index'
  # end

  resources :groups,except:[:new,:edit] do
    resources :works, except: [:new,:edit]
    resources :costs, except: [:new,:edit]
    resources :job_titles do
      resources :assigns, controller: "groups/job_titles/assigns", only: :index
      resources :works, controller: "works", only: :update
    end
  end

  resources :members, except: [:new,:edit] do
    resources :assigns, controller: "members/assigns", only: :index
    resources :projects, controller: "members/projects", only: :index
    resources :assignments, except: [:new,:edit], controller: :projects_members
    resources :members_projects_months, except: [:new,:edit]
    resources :members_months, except: [:new,:edit]
  end

  resources :projects, except: [:new,:edit] do
    resources :assigns, controller: "projects/assigns", only: :index
    resources :members, controller: "projects/members", only: :index
    resources :assignments, except: [:new,:edit], controller: :projects_members
    resources :members_allocations, except: [:new,:edit], controller: :projects_members_months
    resources :allocations, except: [:new,:edit], controller: :projects_monthly_allocations
  end

  # resources :projects_allocations, except: [:new,:edit], controller: :projects_monthly_allocations do
  #   collection do
  #     get :ags
  #   end
  # end

  # get :ags, to: "ags#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
