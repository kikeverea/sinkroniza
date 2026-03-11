class CreateCredentialTags < ActiveRecord::Migration[7.1]
  def change
    create_table :credential_tags do |t|
      t.references :credential, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
