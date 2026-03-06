class WebCompany < ApplicationRecord
  mount_base64_uploader :logo, ImageUploader

  has_many :webs, dependent: :destroy

  validates :name, :web_company_type, presence: true

  enum :web_company_type, {
    bank: "bank",
    other: "other",
    insurance: "insurance",
  }

  def type_text
    I18n.t("activerecord.enums.web_company.web_company_type.#{web_company_type}")
  end
end
