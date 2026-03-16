class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.float :price
      t.integer :max_users
      t.text :description
      t.string :status

      t.timestamps
    end
  end
end
