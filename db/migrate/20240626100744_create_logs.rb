class CreateLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.string :user_name
      t.string :action

      t.timestamps
    end
  end
end
