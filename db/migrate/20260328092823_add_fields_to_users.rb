class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string
    add_column :users, :lastname, :string
    add_column :users, :image, :string
    add_column :users, :jti, :string
    add_column :users, :nif, :string
    add_column :users, :role, :string
    add_column :users, :status, :string
    add_column :users, :last_connection, :datetime
    add_column :users, :date_expiration_password, :datetime
    add_reference :users, :company, null: true, foreign_key: true

    add_index :users, :jti, unique: true
  end
end
