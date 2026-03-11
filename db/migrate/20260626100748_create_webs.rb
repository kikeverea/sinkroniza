class CreateWebs < ActiveRecord::Migration[7.1]
  def change
    create_table :webs do |t|
      t.references :web_company, null: false, foreign_key: true
      t.string :web_company_type
      t.string :name
      t.string :logo
      t.string :favicon
      t.string :access_url
      t.boolean :active, default: true
      t.string :send_button
      t.references :company, null: true, foreign_key: true
      t.references :creator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
