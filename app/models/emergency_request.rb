class EmergencyRequest < ApplicationRecord
  belongs_to :emergency_contact

  enum :status, {
    request: "request",
    approved: "approved",
    rejected: "rejected",
    granted: "granted",
    cancelled: "cancelled",
    expired: "expired",
  },
  default: :request

  def status_text
    I18n.t("activerecord.enums.emergency_request.status.#{status}")
  end
end
