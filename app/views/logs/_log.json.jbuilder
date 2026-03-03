json.extract! log, :id, :user_id, :user_name, :action, :created_at, :updated_at
json.url log_url(log, format: :json)
