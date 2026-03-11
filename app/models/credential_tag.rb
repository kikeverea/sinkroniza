class CredentialTag < ApplicationRecord
  belongs_to :credential
  belongs_to :tag

  validates :tag_id, :credential_id, presence: true
end
