class Web < ApplicationRecord
  before_create :set_creator
  before_save :set_web_company_type

  mount_base64_uploader :logo, ImageUploader

  belongs_to :web_company

  validates :name, presence: true

  enum :status, {
    pending: "pending",
    active: "active",
    rejected: "rejected"
  },
  default: :pending

  def status_text
    I18n.t("activerecord.enums.web.status.#{status}")
  end


  private

  def set_creator
    return if Current.user.nil?

    self.creator_user_id = Current.user.id
    self.creator_user_name = Current.user.full_name
  end

  def set_web_company_type
    self.web_company_type = web_company.web_company_type
  end
end