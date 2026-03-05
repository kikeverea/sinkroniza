class CreateFolders < ActiveRecord::Migration[7.1]
  def change
    create_table :folders do |t|
      t.string :name
      t.references :company, null: true, foreign_key: true
      t.references :parent_folder, null: true, foreign_key: { to_table: :folders }

      t.timestamps
    end
  end
end
