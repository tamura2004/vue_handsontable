# == Route Map
#
#                  Prefix Verb   URI Pattern                                                    Controller#Action
#           post_comments GET    /posts/:post_id/comments(.:format)                             comments#index
#                         POST   /posts/:post_id/comments(.:format)                             comments#create
#        new_post_comment GET    /posts/:post_id/comments/new(.:format)                         comments#new
#            edit_comment GET    /comments/:id/edit(.:format)                                   comments#edit
#                 comment GET    /comments/:id(.:format)                                        comments#show
#                         PATCH  /comments/:id(.:format)                                        comments#update
#                         PUT    /comments/:id(.:format)                                        comments#update
#                         DELETE /comments/:id(.:format)                                        comments#destroy
#              user_posts GET    /users/:user_id/posts(.:format)                                posts#index
#                         POST   /users/:user_id/posts(.:format)                                posts#create
#           new_user_post GET    /users/:user_id/posts/new(.:format)                            posts#new
#               edit_post GET    /posts/:id/edit(.:format)                                      posts#edit
#                    post GET    /posts/:id(.:format)                                           posts#show
#                         PATCH  /posts/:id(.:format)                                           posts#update
#                         PUT    /posts/:id(.:format)                                           posts#update
#                         DELETE /posts/:id(.:format)                                           posts#destroy
#                   users GET    /users(.:format)                                               users#index
#                         POST   /users(.:format)                                               users#create
#                new_user GET    /users/new(.:format)                                           users#new
#               edit_user GET    /users/:id/edit(.:format)                                      users#edit
#                    user GET    /users/:id(.:format)                                           users#show
#                         PATCH  /users/:id(.:format)                                           users#update
#                         PUT    /users/:id(.:format)                                           users#update
#                         DELETE /users/:id(.:format)                                           users#destroy
#                    root GET    /                                                              costs#index {:group_id=>1}
#             departments GET    /departments(.:format)                                         departments#index
#                         POST   /departments(.:format)                                         departments#create
#              department GET    /departments/:id(.:format)                                     departments#show
#                         PATCH  /departments/:id(.:format)                                     departments#update
#                         PUT    /departments/:id(.:format)                                     departments#update
#                         DELETE /departments/:id(.:format)                                     departments#destroy
#              job_titles GET    /job_titles(.:format)                                          job_titles#index
#                         POST   /job_titles(.:format)                                          job_titles#create
#               job_title GET    /job_titles/:id(.:format)                                      job_titles#show
#                         PATCH  /job_titles/:id(.:format)                                      job_titles#update
#                         PUT    /job_titles/:id(.:format)                                      job_titles#update
#                         DELETE /job_titles/:id(.:format)                                      job_titles#destroy
#          upload_results POST   /results/upload(.:format)                                      results#upload
#                 results GET    /results(.:format)                                             results#index
#                  result DELETE /results/:id(.:format)                                         results#destroy
#             group_works GET    /groups/:group_id/works(.:format)                              works#index
#              group_work PATCH  /groups/:group_id/works/:id(.:format)                          works#update
#                         PUT    /groups/:group_id/works/:id(.:format)                          works#update
#             group_costs GET    /groups/:group_id/costs(.:format)                              costs#index
#              group_cost PATCH  /groups/:group_id/costs/:id(.:format)                          costs#update
#                         PUT    /groups/:group_id/costs/:id(.:format)                          costs#update
# group_job_title_assigns GET    /groups/:group_id/job_titles/:job_title_id/assigns(.:format)   groups/job_titles/assigns#index
#    group_job_title_work PATCH  /groups/:group_id/job_titles/:job_title_id/works/:id(.:format) works#update
#                         PUT    /groups/:group_id/job_titles/:job_title_id/works/:id(.:format) works#update
#        group_job_titles GET    /groups/:group_id/job_titles(.:format)                         job_titles#index
#                         POST   /groups/:group_id/job_titles(.:format)                         job_titles#create
#     new_group_job_title GET    /groups/:group_id/job_titles/new(.:format)                     job_titles#new
#    edit_group_job_title GET    /groups/:group_id/job_titles/:id/edit(.:format)                job_titles#edit
#         group_job_title GET    /groups/:group_id/job_titles/:id(.:format)                     job_titles#show
#                         PATCH  /groups/:group_id/job_titles/:id(.:format)                     job_titles#update
#                         PUT    /groups/:group_id/job_titles/:id(.:format)                     job_titles#update
#                         DELETE /groups/:group_id/job_titles/:id(.:format)                     job_titles#destroy
#    group_member_assigns GET    /groups/:group_id/members/:member_id/assigns(.:format)         members/assigns#index
#   group_member_projects GET    /groups/:group_id/members/:member_id/projects(.:format)        members/projects#index
#           group_members GET    /groups/:group_id/members(.:format)                            members#index
#                         POST   /groups/:group_id/members(.:format)                            members#create
#            group_member GET    /groups/:group_id/members/:id(.:format)                        members#show
#                         PATCH  /groups/:group_id/members/:id(.:format)                        members#update
#                         PUT    /groups/:group_id/members/:id(.:format)                        members#update
#                         DELETE /groups/:group_id/members/:id(.:format)                        members#destroy
#   group_project_assigns GET    /groups/:group_id/projects/:project_id/assigns(.:format)       projects/assigns#index
#   group_project_members GET    /groups/:group_id/projects/:project_id/members(.:format)       projects/members#index
#          group_projects GET    /groups/:group_id/projects(.:format)                           projects#index
#                         POST   /groups/:group_id/projects(.:format)                           projects#create
#           group_project GET    /groups/:group_id/projects/:id(.:format)                       projects#show
#                         PATCH  /groups/:group_id/projects/:id(.:format)                       projects#update
#                         PUT    /groups/:group_id/projects/:id(.:format)                       projects#update
#                         DELETE /groups/:group_id/projects/:id(.:format)                       projects#destroy
#                  groups GET    /groups(.:format)                                              groups#index
#                         POST   /groups(.:format)                                              groups#create
#                   group GET    /groups/:id(.:format)                                          groups#show
#                         PATCH  /groups/:id(.:format)                                          groups#update
#                         PUT    /groups/:id(.:format)                                          groups#update
#                         DELETE /groups/:id(.:format)                                          groups#destroy
#

Rails.application.routes.draw do

  root "costs#index", group_id: 1

  resources :departments             , except: [:new,:edit]
  resources :job_titles              , except: [:new,:edit]

  resources :results, only: [:index,:destroy] do
    collection do
      post :upload
    end
  end

  resources :groups,except:[:new,:edit] do
    resources :works, only: [:index,:update]
    resources :costs, only: [:index,:update]

    resources :job_titles do
      resources :assigns, controller: "groups/job_titles/assigns", only: :index
      resources :works, controller: "works", only: :update
    end
  end

    resources :members, except: [:new,:edit] do
      resources :assigns, controller: "members/assigns", only: :index
      resources :projects, controller: "members/projects", only: :index

      # resources :assignments, except: [:new,:edit], controller: :projects_members
      # resources :members_projects_months, except: [:new,:edit]
      # resources :members_months, except: [:new,:edit]
    end

    resources :projects, except: [:new,:edit] do
      resources :assigns, controller: "projects/assigns", only: :index
      resources :members, controller: "projects/members", only: :index

      # resources :assignments, except: [:new,:edit], controller: :projects_members
      # resources :members_allocations, except: [:new,:edit], controller: :projects_members_months
      # resources :allocations, except: [:new,:edit], controller: :projects_monthly_allocations
    end

end
