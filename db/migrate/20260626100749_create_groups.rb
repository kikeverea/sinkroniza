class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.references :company, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.integer :created_by_user_id
      t.string :group_type

      t.timestamps
    end
  end
end
