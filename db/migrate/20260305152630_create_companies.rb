class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.references :subscription, null: false, foreign_key: true
      t.string :name
      t.string :legal_name
      t.string :tax_id
      t.text :address
      t.string :cp
      t.string :logo
      t.string :manager_name
      t.string :manager_lastname
      t.string :manager_email
      t.string :manager_nif
      t.string :manager_phone
      t.boolean :active, default: true
      t.integer :creator_user_id
      t.string :creator_user_name
      t.string :status

      t.timestamps
    end
  end
end
