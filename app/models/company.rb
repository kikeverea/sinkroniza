class Company < ApplicationRecord
  before_create :set_creator

  belongs_to :subscription
  belongs_to :manager, class_name: "User"
  belongs_to :creator, class_name: "User"
  has_many :users, dependent: :destroy

  mount_base64_uploader :logo, ImageUploader

  validates :subscription_id, :manager_id, :name, presence: true
  validate :manager_must_be_company_admin

  accepts_nested_attributes_for :manager

  enum :status, {
    active: "active",
    inactive: "inactive"
  },
  default: :active

  def status_text
    I18n.t("activerecord.enums.company.status.#{status}")
  end

  def full_address
    address.present? && cp.present? ? "#{address}, #{cp}" : address
  end

  def can_add_user?
    users.kept.count < subscription.max_users
  end

  private

  def manager_must_be_company_admin
    errors.add(:manager, "Manager must have the company admin role") unless manager.role == "company_admin"
  end

  def set_creator
    return if Current.user.nil?
    self.creator ||= Current.user
  end
end
