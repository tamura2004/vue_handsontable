# == Route Map
#
#                         Prefix Verb   URI Pattern                                                    Controller#Action
#                          seats GET    /seats(.:format)                                               seats#index
#                                POST   /seats(.:format)                                               seats#create
#                       new_seat GET    /seats/new(.:format)                                           seats#new
#                      edit_seat GET    /seats/:id/edit(.:format)                                      seats#edit
#                           seat GET    /seats/:id(.:format)                                           seats#show
#                                PATCH  /seats/:id(.:format)                                           seats#update
#                                PUT    /seats/:id(.:format)                                           seats#update
#                                DELETE /seats/:id(.:format)                                           seats#destroy
#                 upload_results POST   /results/upload(.:format)                                      results#upload
#                        results GET    /results(.:format)                                             results#index
#                         result DELETE /results/:id(.:format)                                         results#destroy
#         members_projects_index GET    /members/projects/index(.:format)                              members/projects#index
#          project_assigns_index GET    /project/assigns/index(.:format)                               project/assigns#index
#                          costs GET    /costs(.:format)                                               costs#index
#                                POST   /costs(.:format)                                               costs#create
#                       new_cost GET    /costs/new(.:format)                                           costs#new
#                      edit_cost GET    /costs/:id/edit(.:format)                                      costs#edit
#                           cost GET    /costs/:id(.:format)                                           costs#show
#                                PATCH  /costs/:id(.:format)                                           costs#update
#                                PUT    /costs/:id(.:format)                                           costs#update
#                                DELETE /costs/:id(.:format)                                           costs#destroy
#                          works GET    /works(.:format)                                               works#index
#                                POST   /works(.:format)                                               works#create
#                       new_work GET    /works/new(.:format)                                           works#new
#                      edit_work GET    /works/:id/edit(.:format)                                      works#edit
#                           work GET    /works/:id(.:format)                                           works#show
#                                PATCH  /works/:id(.:format)                                           works#update
#                                PUT    /works/:id(.:format)                                           works#update
#                                DELETE /works/:id(.:format)                                           works#destroy
#                groups_projects GET    /groups_projects(.:format)                                     groups_projects#index
#                                POST   /groups_projects(.:format)                                     groups_projects#create
#             new_groups_project GET    /groups_projects/new(.:format)                                 groups_projects#new
#            edit_groups_project GET    /groups_projects/:id/edit(.:format)                            groups_projects#edit
#                 groups_project GET    /groups_projects/:id(.:format)                                 groups_projects#show
#                                PATCH  /groups_projects/:id(.:format)                                 groups_projects#update
#                                PUT    /groups_projects/:id(.:format)                                 groups_projects#update
#                                DELETE /groups_projects/:id(.:format)                                 groups_projects#destroy
#                    group_works GET    /groups/:group_id/works(.:format)                              works#index
#                                POST   /groups/:group_id/works(.:format)                              works#create
#                 new_group_work GET    /groups/:group_id/works/new(.:format)                          works#new
#                edit_group_work GET    /groups/:group_id/works/:id/edit(.:format)                     works#edit
#                     group_work GET    /groups/:group_id/works/:id(.:format)                          works#show
#                                PATCH  /groups/:group_id/works/:id(.:format)                          works#update
#                                PUT    /groups/:group_id/works/:id(.:format)                          works#update
#                                DELETE /groups/:group_id/works/:id(.:format)                          works#destroy
#                    group_costs GET    /groups/:group_id/costs(.:format)                              costs#index
#                                POST   /groups/:group_id/costs(.:format)                              costs#create
#                 new_group_cost GET    /groups/:group_id/costs/new(.:format)                          costs#new
#                edit_group_cost GET    /groups/:group_id/costs/:id/edit(.:format)                     costs#edit
#                     group_cost GET    /groups/:group_id/costs/:id(.:format)                          costs#show
#                                PATCH  /groups/:group_id/costs/:id(.:format)                          costs#update
#                                PUT    /groups/:group_id/costs/:id(.:format)                          costs#update
#                                DELETE /groups/:group_id/costs/:id(.:format)                          costs#destroy
#        group_job_title_assigns GET    /groups/:group_id/job_titles/:job_title_id/assigns(.:format)   groups/job_titles/assigns#index
#           group_job_title_work PATCH  /groups/:group_id/job_titles/:job_title_id/works/:id(.:format) works#update
#                                PUT    /groups/:group_id/job_titles/:job_title_id/works/:id(.:format) works#update
#               group_job_titles GET    /groups/:group_id/job_titles(.:format)                         job_titles#index
#                                POST   /groups/:group_id/job_titles(.:format)                         job_titles#create
#            new_group_job_title GET    /groups/:group_id/job_titles/new(.:format)                     job_titles#new
#           edit_group_job_title GET    /groups/:group_id/job_titles/:id/edit(.:format)                job_titles#edit
#                group_job_title GET    /groups/:group_id/job_titles/:id(.:format)                     job_titles#show
#                                PATCH  /groups/:group_id/job_titles/:id(.:format)                     job_titles#update
#                                PUT    /groups/:group_id/job_titles/:id(.:format)                     job_titles#update
#                                DELETE /groups/:group_id/job_titles/:id(.:format)                     job_titles#destroy
#                         groups GET    /groups(.:format)                                              groups#index
#                                POST   /groups(.:format)                                              groups#create
#                          group GET    /groups/:id(.:format)                                          groups#show
#                                PATCH  /groups/:id(.:format)                                          groups#update
#                                PUT    /groups/:id(.:format)                                          groups#update
#                                DELETE /groups/:id(.:format)                                          groups#destroy
#                    departments GET    /departments(.:format)                                         departments#index
#                                POST   /departments(.:format)                                         departments#create
#                     department GET    /departments/:id(.:format)                                     departments#show
#                                PATCH  /departments/:id(.:format)                                     departments#update
#                                PUT    /departments/:id(.:format)                                     departments#update
#                                DELETE /departments/:id(.:format)                                     departments#destroy
#                     job_titles GET    /job_titles(.:format)                                          job_titles#index
#                                POST   /job_titles(.:format)                                          job_titles#create
#                      job_title GET    /job_titles/:id(.:format)                                      job_titles#show
#                                PATCH  /job_titles/:id(.:format)                                      job_titles#update
#                                PUT    /job_titles/:id(.:format)                                      job_titles#update
#                                DELETE /job_titles/:id(.:format)                                      job_titles#destroy
#        members_projects_months GET    /members_projects_months(.:format)                             members_projects_months#index
#                                POST   /members_projects_months(.:format)                             members_projects_months#create
#         members_projects_month GET    /members_projects_months/:id(.:format)                         members_projects_months#show
#                                PATCH  /members_projects_months/:id(.:format)                         members_projects_months#update
#                                PUT    /members_projects_months/:id(.:format)                         members_projects_months#update
#                                DELETE /members_projects_months/:id(.:format)                         members_projects_months#destroy
#                 members_months GET    /members_months(.:format)                                      members_months#index
#                                POST   /members_months(.:format)                                      members_months#create
#                  members_month GET    /members_months/:id(.:format)                                  members_months#show
#                                PATCH  /members_months/:id(.:format)                                  members_months#update
#                                PUT    /members_months/:id(.:format)                                  members_months#update
#                                DELETE /members_months/:id(.:format)                                  members_months#destroy
#                 member_assigns GET    /members/:member_id/assigns(.:format)                          members/assigns#index
#                member_projects GET    /members/:member_id/projects(.:format)                         members/projects#index
#             member_assignments GET    /members/:member_id/assignments(.:format)                      projects_members#index
#                                POST   /members/:member_id/assignments(.:format)                      projects_members#create
#              member_assignment GET    /members/:member_id/assignments/:id(.:format)                  projects_members#show
#                                PATCH  /members/:member_id/assignments/:id(.:format)                  projects_members#update
#                                PUT    /members/:member_id/assignments/:id(.:format)                  projects_members#update
#                                DELETE /members/:member_id/assignments/:id(.:format)                  projects_members#destroy
# member_members_projects_months GET    /members/:member_id/members_projects_months(.:format)          members_projects_months#index
#                                POST   /members/:member_id/members_projects_months(.:format)          members_projects_months#create
#  member_members_projects_month GET    /members/:member_id/members_projects_months/:id(.:format)      members_projects_months#show
#                                PATCH  /members/:member_id/members_projects_months/:id(.:format)      members_projects_months#update
#                                PUT    /members/:member_id/members_projects_months/:id(.:format)      members_projects_months#update
#                                DELETE /members/:member_id/members_projects_months/:id(.:format)      members_projects_months#destroy
#          member_members_months GET    /members/:member_id/members_months(.:format)                   members_months#index
#                                POST   /members/:member_id/members_months(.:format)                   members_months#create
#           member_members_month GET    /members/:member_id/members_months/:id(.:format)               members_months#show
#                                PATCH  /members/:member_id/members_months/:id(.:format)               members_months#update
#                                PUT    /members/:member_id/members_months/:id(.:format)               members_months#update
#                                DELETE /members/:member_id/members_months/:id(.:format)               members_months#destroy
#                        members GET    /members(.:format)                                             members#index
#                                POST   /members(.:format)                                             members#create
#                         member GET    /members/:id(.:format)                                         members#show
#                                PATCH  /members/:id(.:format)                                         members#update
#                                PUT    /members/:id(.:format)                                         members#update
#                                DELETE /members/:id(.:format)                                         members#destroy
#                project_assigns GET    /projects/:project_id/assigns(.:format)                        projects/assigns#index
#                project_members GET    /projects/:project_id/members(.:format)                        projects/members#index
#            project_assignments GET    /projects/:project_id/assignments(.:format)                    projects_members#index
#                                POST   /projects/:project_id/assignments(.:format)                    projects_members#create
#             project_assignment GET    /projects/:project_id/assignments/:id(.:format)                projects_members#show
#                                PATCH  /projects/:project_id/assignments/:id(.:format)                projects_members#update
#                                PUT    /projects/:project_id/assignments/:id(.:format)                projects_members#update
#                                DELETE /projects/:project_id/assignments/:id(.:format)                projects_members#destroy
#    project_members_allocations GET    /projects/:project_id/members_allocations(.:format)            projects_members_months#index
#                                POST   /projects/:project_id/members_allocations(.:format)            projects_members_months#create
#     project_members_allocation GET    /projects/:project_id/members_allocations/:id(.:format)        projects_members_months#show
#                                PATCH  /projects/:project_id/members_allocations/:id(.:format)        projects_members_months#update
#                                PUT    /projects/:project_id/members_allocations/:id(.:format)        projects_members_months#update
#                                DELETE /projects/:project_id/members_allocations/:id(.:format)        projects_members_months#destroy
#            project_allocations GET    /projects/:project_id/allocations(.:format)                    projects_monthly_allocations#index
#                                POST   /projects/:project_id/allocations(.:format)                    projects_monthly_allocations#create
#             project_allocation GET    /projects/:project_id/allocations/:id(.:format)                projects_monthly_allocations#show
#                                PATCH  /projects/:project_id/allocations/:id(.:format)                projects_monthly_allocations#update
#                                PUT    /projects/:project_id/allocations/:id(.:format)                projects_monthly_allocations#update
#                                DELETE /projects/:project_id/allocations/:id(.:format)                projects_monthly_allocations#destroy
#                       projects GET    /projects(.:format)                                            projects#index
#                                POST   /projects(.:format)                                            projects#create
#                        project GET    /projects/:id(.:format)                                        projects#show
#                                PATCH  /projects/:id(.:format)                                        projects#update
#                                PUT    /projects/:id(.:format)                                        projects#update
#                                DELETE /projects/:id(.:format)                                        projects#destroy
#       ags_projects_allocations GET    /projects_allocations/ags(.:format)                            projects_monthly_allocations#ags
#           projects_allocations GET    /projects_allocations(.:format)                                projects_monthly_allocations#index
#                                POST   /projects_allocations(.:format)                                projects_monthly_allocations#create
#            projects_allocation GET    /projects_allocations/:id(.:format)                            projects_monthly_allocations#show
#                                PATCH  /projects_allocations/:id(.:format)                            projects_monthly_allocations#update
#                                PUT    /projects_allocations/:id(.:format)                            projects_monthly_allocations#update
#                                DELETE /projects_allocations/:id(.:format)                            projects_monthly_allocations#destroy
#                            ags GET    /ags(.:format)                                                 ags#index
#                    whereareyou GET    /whereareyou(.:format)                                         whereareyou#index
#                           root GET    /                                                              costs#index {:group_id=>1}
#

Rails.application.routes.draw do

  resources :results, only: [:index,:destroy] do
    collection do
      post :upload
    end
  end

  namespace :members do
    get 'projects/index'
  end

  namespace :project do
    get 'assigns/index'
  end

  resources :costs
  resources :works
  # get "init_works", to: "works#seed"

  resources :groups_projects

  resources :groups,except:[:new,:edit] do
    resources :works
    resources :costs
    resources :job_titles do
      resources :assigns, controller: "groups/job_titles/assigns", only: :index
      resources :works, controller: "works", only: :update
    end
  end

  resources :departments , except: [:new,:edit]
  resources :job_titles  , except: [:new,:edit]

  resources :members_projects_months , except: [:new,:edit]
  resources :members_months          , except: [:new,:edit]

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

  resources :projects_allocations, except: [:new,:edit], controller: :projects_monthly_allocations do
    collection do
      get :ags
    end
  end

  get :ags, to: "ags#index"
  get :whereareyou, to: "whereareyou#index"

  root "costs#index", group_id: 1
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
