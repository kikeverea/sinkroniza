class WebCompany < ApplicationRecord
  company_scoped optional: true

  mount_base64_uploader :logo, ImageUploader
  mount_base64_uploader :favicon, FaviconUploader

  has_many :webs, dependent: :destroy

  validates :name, :web_company_type, presence: true

  def self.ransackable_associations(_auth_object = nil)
    []
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[ name created_at ]
  end

  enum :web_company_type, {
    bank: "bank",
    other: "other",
    insurance: "insurance",
  }

  def type_text
    I18n.t("activerecord.enums.web_company.web_company_type.#{web_company_type}")
  end

  def as_json(options = nil)
    {
      id: id,
      name: name,
      logo: logo&.url,
      favicon: favicon&.url,
      web_company_type: type_text,
      webs: webs.accessible_by(Current.ability).map(&:as_json)
    }
  end
end
