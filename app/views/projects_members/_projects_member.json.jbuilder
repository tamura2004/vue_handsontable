json.extract! projects_member, :id, :project_id, :member_id, :created_at, :updated_at
json.url projects_member_url(projects_member, format: :json)