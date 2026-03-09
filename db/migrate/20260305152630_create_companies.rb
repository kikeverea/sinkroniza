class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :legal_name
      t.string :tax_id
      t.text :address
      t.string :cp
      t.string :logo
      t.string :status
      t.references :subscription, null: false, foreign_key: true
      t.references :manager, null: false, foreign_key: { to_table: :users }
      t.references :creator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
