json.extract! company, :id, :subscription_id, :name, :legal_name, :tax_id, :address, :cp, :logo, :manager_name, :manager_lastname, :manager_email, :manager_nif, :manager_phone, :active, :creator_user_id, :creator_user_name, :status, :created_at, :updated_at
json.url company_url(company, format: :json)
