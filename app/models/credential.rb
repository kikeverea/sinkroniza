class Credential < ApplicationRecord
  company_scoped

  belongs_to :web
  belongs_to :group, optional: true
  has_many :credential_tags, dependent: :destroy
  has_many :tags, through: :credential_tags

  validates :web, :name, :credential_type, presence: true

  enum :credential_type, {
    autologin: "autologin",
    regular: "regular",
    note: "note",
  }

  def credential_type_text
    I18n.t("activerecord.enums.credential.credential_type.#{credential_type}")
  end
end
