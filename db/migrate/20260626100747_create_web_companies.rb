class CreateWebCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :web_companies do |t|
      t.string :name
      t.string :logo
      t.string :favicon
      t.string :web_company_type
      t.references :company, null: true, foreign_key: true

      t.timestamps
    end
  end
end
