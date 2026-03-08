json.extract! web, :id, :web_company_id, :web_company_type, :name, :alias, :logo, :access_url, :active, :creator_user_id, :creator_user_name, :status, :send_button, :created_at, :updated_at
json.url web_url(web, format: :json)
