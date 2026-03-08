class CreateEmergencyRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :emergency_requests do |t|
      t.references :emergency_contact, null: false, foreign_key: true
      t.string :status
      t.datetime :manual_ar_at
      t.datetime :grant_at
      t.datetime :granted_at

      t.timestamps
    end
  end
end
