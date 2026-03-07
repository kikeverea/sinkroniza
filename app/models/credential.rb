class Credential < ApplicationRecord
  belongs_to :company
  belongs_to :web
  belongs_to :folder, optional: true
  belongs_to :group, optional: true

  validates :company_id, :web, :name, :credential_type, presence: true

  enum :credential_type, {
    autologin: "autologin",
    regular: "regular",
    note: "note",
  }

  def credential_type_text
    I18n.t("activerecord.enums.credential.credential_type.#{credential_type}")
  end
end
