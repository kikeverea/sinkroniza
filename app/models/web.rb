class Web < ApplicationRecord
  include Taggable

  company_scoped optional: true

  before_validation :set_creator, on: :create
  before_save :set_web_company_type
  after_save :set_web_company_images

  mount_base64_uploader :logo, ImageUploader
  mount_uploader :favicon, FaviconUploader

  belongs_to :creator, class_name: "User"
  belongs_to :web_company
  has_many :credentials

  validates :name, :access_url, presence: true

  def favicon
    value = super
    value.present? ? value : web_company.favicon
  end

  def favicon?
    favicon.present?
  end

  def display_access_url
    max_length = 72
    display = access_url.split("?").first
    display.length > max_length ? "#{display.first(max_length - 3)}..." : display
  end


  def as_json(options = nil)
    {
      id: id,
      name: name,
      logo: logo&.url,
      url: access_url,
      credentials: credentials.accessible_by(Current.ability).map(&:as_json)
    }
  end

  private

  def set_creator
    return if Current.user.nil?
    self.creator = Current.user
  end

  def set_web_company_type
    self.web_company_type ||= web_company.web_company_type
  end

  def set_web_company_images
    web_company = self.web_company
    return if web_company.logo? && web_company.favicon?

    web_company.logo = self.logo if web_company.logo.blank? && self.logo.present?
    web_company.favicon = self.favicon if web_company.favicon.blank? && self.favicon.present?

    web_company.save
  end
end