class CreateWebs < ActiveRecord::Migration[7.1]
  def change
    create_table :webs do |t|
      t.references :web_company, null: false, foreign_key: true
      t.string :web_company_type
      t.string :name
      t.string :alias
      t.string :logo
      t.string :access_url
      t.boolean :active, default: true
      t.integer :creator_user_id
      t.string :creator_user_name
      t.string :status
      t.string :send_button

      t.timestamps
    end
  end
end
