class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.references :company, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.string :group_type
      t.references :creator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
