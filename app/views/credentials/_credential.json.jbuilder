json.extract! credential, :id, :group_id, :company_id, :web_id, :folder_id, :web_company_type, :name, :description, :admin_description, :encrypted_blob, :mediator_code, :priority, :owner, :visible_extension, :active, :credential_type, :created_at, :updated_at
json.url credential_url(credential, format: :json)
