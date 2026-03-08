json.extract! emergency_contact, :id, :owner_user_id, :contact_user_id, :company_id, :status, :wait_days, :encrypted_payload, :crypto_version, :created_at, :updated_at
json.url emergency_contact_url(emergency_contact, format: :json)
