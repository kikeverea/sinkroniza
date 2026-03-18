class CreateTags < ActiveRecord::Migration[7.1]
  def change
    create_table :tags do |t|
      t.string :name
      t.string :color
      t.references :company, null: true, foreign_key: true

      t.timestamps
    end
  end
end
