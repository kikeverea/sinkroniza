class CreateCredentials < ActiveRecord::Migration[7.1]
  def change
    create_table :credentials do |t|
      t.string :web_company_type
      t.string :name
      t.text :description
      t.text :admin_description
      t.text :encrypted_blob
      t.string :mediator_code
      t.string :priority
      t.string :owner
      t.boolean :visible_extension
      t.boolean :active, default: true
      t.string :credential_type
      t.references :company, null: false, foreign_key: true
      t.references :web, null: false, foreign_key: true
      t.references :group, null: true, foreign_key: true

      t.timestamps
    end
  end
end
