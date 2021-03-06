# == Route Map
#
#                               Prefix Verb   URI Pattern                                                    Controller#Action
#                          rails_admin        /admin                                                         RailsAdmin::Engine
#                            plans_new GET    /plans/new(.:format)                                           plans#new
#                                plans GET    /plans(.:format)                                               plans#index
#                                      POST   /plans(.:format)                                               plans#create
#                        plans_compare GET    /plans/compare(.:format)                                       plans#compare
#                assigns_member_report GET    /assigns/member_report(.:format)                               assigns#member_report
#              assigns_projects_report GET    /assigns/projects_report(.:format)                             assigns#projects_report
#                        assigns_chart GET    /assigns/chart(.:format)                                       assigns#chart
#                 assigns_member_chart GET    /assigns/member_chart(.:format)                                assigns#member_chart
#                assigns_project_chart GET    /assigns/project_chart(.:format)                               assigns#project_chart
#                                 root GET    /                                                              assigns#projects_report
# members_projects_allocs_circle_chart GET    /members/projects/allocs/circle_chart(.:format)                members/projects/allocs#circle_chart
#                       upload_results POST   /results/upload(.:format)                                      results#upload
#                              results GET    /results(.:format)                                             results#index
#                               result DELETE /results/:id(.:format)                                         results#destroy
#                          group_works GET    /groups/:group_id/works(.:format)                              works#index
#                           group_work PATCH  /groups/:group_id/works/:id(.:format)                          works#update
#                                      PUT    /groups/:group_id/works/:id(.:format)                          works#update
#                          group_costs GET    /groups/:group_id/costs(.:format)                              costs#index
#                           group_cost PATCH  /groups/:group_id/costs/:id(.:format)                          costs#update
#                                      PUT    /groups/:group_id/costs/:id(.:format)                          costs#update
#                         group_allocs GET    /groups/:group_id/allocs(.:format)                             groups/allocs#index
#              group_job_title_assigns GET    /groups/:group_id/job_titles/:job_title_id/assigns(.:format)   groups/job_titles/assigns#index
#               group_job_title_allocs GET    /groups/:group_id/job_titles/:job_title_id/allocs(.:format)    groups/job_titles/assigns#index
#                 group_job_title_work PATCH  /groups/:group_id/job_titles/:job_title_id/works/:id(.:format) works#update
#                                      PUT    /groups/:group_id/job_titles/:job_title_id/works/:id(.:format) works#update
#                     group_job_titles GET    /groups/:group_id/job_titles(.:format)                         job_titles#index
#                                      POST   /groups/:group_id/job_titles(.:format)                         job_titles#create
#                  new_group_job_title GET    /groups/:group_id/job_titles/new(.:format)                     job_titles#new
#                 edit_group_job_title GET    /groups/:group_id/job_titles/:id/edit(.:format)                job_titles#edit
#                      group_job_title GET    /groups/:group_id/job_titles/:id(.:format)                     job_titles#show
#                                      PATCH  /groups/:group_id/job_titles/:id(.:format)                     job_titles#update
#                                      PUT    /groups/:group_id/job_titles/:id(.:format)                     job_titles#update
#                                      DELETE /groups/:group_id/job_titles/:id(.:format)                     job_titles#destroy
#                               groups GET    /groups(.:format)                                              groups#index
#                                      POST   /groups(.:format)                                              groups#create
#                                group GET    /groups/:id(.:format)                                          groups#show
#                                      PATCH  /groups/:id(.:format)                                          groups#update
#                                      PUT    /groups/:id(.:format)                                          groups#update
#                                      DELETE /groups/:id(.:format)                                          groups#destroy
#                        member_allocs GET    /members/:member_id/allocs(.:format)                           members/allocs#index
#                         member_alloc PATCH  /members/:member_id/allocs/:id(.:format)                       members/allocs#update
#                                      PUT    /members/:member_id/allocs/:id(.:format)                       members/allocs#update
#                       member_assigns GET    /members/:member_id/assigns(.:format)                          members/assigns#index
#                                      POST   /members/:member_id/assigns(.:format)                          members/assigns#create
#                        member_assign DELETE /members/:member_id/assigns/:id(.:format)                      members/assigns#destroy
#                          member_work PATCH  /members/:member_id/works/:id(.:format)                        works#update
#                                      PUT    /members/:member_id/works/:id(.:format)                        works#update
#                              members GET    /members(.:format)                                             members#index
#                                      POST   /members(.:format)                                             members#create
#                               member GET    /members/:id(.:format)                                         members#show
#                                      PATCH  /members/:id(.:format)                                         members#update
#                                      PUT    /members/:id(.:format)                                         members#update
#                                      DELETE /members/:id(.:format)                                         members#destroy
#                       project_allocs GET    /projects/:project_id/allocs(.:format)                         projects/allocs#index
#                        project_alloc PATCH  /projects/:project_id/allocs/:id(.:format)                     projects/allocs#update
#                                      PUT    /projects/:project_id/allocs/:id(.:format)                     projects/allocs#update
#                      project_assigns GET    /projects/:project_id/assigns(.:format)                        projects/assigns#index
#                                      POST   /projects/:project_id/assigns(.:format)                        projects/assigns#create
#                       project_assign DELETE /projects/:project_id/assigns/:id(.:format)                    projects/assigns#destroy
#                         project_cost PATCH  /projects/:project_id/costs/:id(.:format)                      costs#update
#                                      PUT    /projects/:project_id/costs/:id(.:format)                      costs#update
#       project_projects_members_month PATCH  /projects/:project_id/projects_members_months/:id(.:format)    projects_members_months#update
#                                      PUT    /projects/:project_id/projects_members_months/:id(.:format)    projects_members_months#update
#                                      DELETE /projects/:project_id/projects_members_months/:id(.:format)    projects_members_months#destroy
#                             projects GET    /projects(.:format)                                            projects#index
#                                      POST   /projects(.:format)                                            projects#create
#                          new_project GET    /projects/new(.:format)                                        projects#new
#                              project GET    /projects/:id(.:format)                                        projects#show
#                                      PATCH  /projects/:id(.:format)                                        projects#update
#                                      PUT    /projects/:id(.:format)                                        projects#update
#                                      DELETE /projects/:id(.:format)                                        projects#destroy
#
# Routes for RailsAdmin::Engine:
#   dashboard GET         /                                      rails_admin/main#dashboard
#       index GET|POST    /:model_name(.:format)                 rails_admin/main#index
#         new GET|POST    /:model_name/new(.:format)             rails_admin/main#new
#      export GET|POST    /:model_name/export(.:format)          rails_admin/main#export
# bulk_delete POST|DELETE /:model_name/bulk_delete(.:format)     rails_admin/main#bulk_delete
# bulk_action POST        /:model_name/bulk_action(.:format)     rails_admin/main#bulk_action
#        show GET         /:model_name/:id(.:format)             rails_admin/main#show
#        edit GET|PUT     /:model_name/:id/edit(.:format)        rails_admin/main#edit
#      delete GET|DELETE  /:model_name/:id/delete(.:format)      rails_admin/main#delete
# show_in_app GET         /:model_name/:id/show_in_app(.:format) rails_admin/main#show_in_app
#

# No route matches [PUT] "/projects/27/assignment/1"


Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'


  get "login" => "sessions#create", as: :login
  delete "session" => "sessions#destroy", as: :logout

  get "plans/new", to: "plans#new"
  get "plans", to: "plans#index"
  post "plans", to: "plans#create"
  get "plans/compare", to: "plans#compare"

  get "assigns/member_report"
  get "assigns/allocs_report"
  get "assigns/projects_report"
  get "assigns/chart"
  get "assigns/member_chart"
  get "assigns/project_chart"

  root "assigns#member_chart"

  namespace :members do
    namespace :projects do
      get "allocs/circle_chart"
    end
  end

  resources :results, only: [:index,:destroy] do
    collection do
      post :upload
    end
  end

  resources :groups,except:[:new,:edit] do
    resources :works, only: [:index,:update]
    resources :costs, only: [:index,:update]

    resources :allocs, only: :index, controller: "groups/allocs"

    resources :job_titles do
      resources :assigns, controller: "groups/job_titles/assigns", only: :index
      resources :allocs, controller: "groups/job_titles/assigns", only: :index
      resources :works, controller: "works", only: :update
    end
  end

  resources :members, except: [:new,:edit] do
    resources :allocs, controller: "members/allocs", only: [:index,:update]
    resources :assigns, controller: "members/assigns", only: [:index,:create,:destroy]
    resources :works, only: :update
  end

  resources :projects, except: [:edit] do
    resources :allocs, controller: "projects/allocs", only: [:index,:update]
    resources :assigns, controller: "projects/assigns", only: [:index,:create,:destroy]
    resources :costs, only: :update
    resources :projects_members_months, only: [:update, :destroy]
  end

  namespace :api, { format: "json" } do
    namespace :v1 do
      resources :assigns, only: [:index]
      resources :projects, only: [:index]
      resources :months, only: [:index]
      resources :members, only: [:index] do
        resources :allocs, only: [:index], module: :members
      end
    end
  end

  namespace :v1 do
    resources :members, only: [:index] do
      resources :allocs, only: [:index], module: :members
    end
  end
end
