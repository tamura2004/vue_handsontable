json.extract! projects_monthly_allocation, :id, :project_id, :month, :cost, :created_at, :updated_at
json.url projects_monthly_allocation_url(projects_monthly_allocation, format: :json)