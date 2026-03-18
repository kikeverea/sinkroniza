class Web < ApplicationRecord
  include Taggable

  company_scoped optional: true

  before_validation :set_creator, on: :create
  before_save :set_web_company_type

  mount_base64_uploader :logo, ImageUploader
  mount_base64_uploader :favicon, FaviconUploader

  belongs_to :creator, class_name: "User"
  belongs_to :web_company

  validates :name, :access_url, presence: true

  def favicon
    value = super
    value.present? ? value : web_company.favicon
  end

  def favicon?
    favicon.present?
  end


  private

  def set_creator
    return if Current.user.nil?
    self.creator = Current.user
  end

  def set_web_company_type
    self.web_company_type ||= web_company.web_company_type
  end
end