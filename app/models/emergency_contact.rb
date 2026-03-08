class EmergencyContact < ApplicationRecord
  before_validation :set_company

  belongs_to :owner_user, class_name: "User"
  belongs_to :contact_user, class_name: "User"
  belongs_to :company
  has_many :emergency_requests, dependent: :destroy

  validates :owner_user_id, :contact_user_id, :company_id, presence: true

  enum :status, {
    invited: "invited",
    active: "active",
    revoked: "revoked"
  },
  default: :invited

  def status_text
    I18n.t("activerecord.enums.emergency_contact.status.#{status}")
  end


  private

  def set_company
    return unless company_id.nil?

    self.company = contact_user.company
  end
end
