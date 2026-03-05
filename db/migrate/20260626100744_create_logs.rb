class CreateLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.string :user_name
      t.integer :company_id
      t.string :company_name
      t.text :action
      t.string :log_type

      t.timestamps
    end
  end
end
