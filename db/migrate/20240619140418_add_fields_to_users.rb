class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role, :string
    add_column :users, :name, :string
    add_column :users, :lastname, :string
    add_column :users, :image, :string
    add_column :users, :jti, :string

    add_index :users, :jti, unique: true
  end
end
