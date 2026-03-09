class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.text :description
      t.integer :max_users
      t.string :status

      t.timestamps
    end
  end
end
