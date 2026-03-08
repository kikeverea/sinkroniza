class CreateEmergencyContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :emergency_contacts do |t|
      t.string :status
      t.integer :wait_days
      t.text :encrypted_payload
      t.string :crypto_version
      t.references :owner_user, null: false, foreign_key: { to_table: :users }
      t.references :contact_user, null: false, foreign_key: { to_table: :users }
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
