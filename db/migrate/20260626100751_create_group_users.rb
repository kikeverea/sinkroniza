class CreateGroupUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :group_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.text :encrypted_group_key
      t.string :crypto_version
      t.string :group_type
      t.string :role

      t.timestamps
    end
  end
end
