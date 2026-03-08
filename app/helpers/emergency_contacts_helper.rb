module EmergencyContactsHelper

  def emergency_contact_status_text(status)
    I18n.t("activerecord.enums.emergency_contact.status.#{status}")
  end

  def emergency_contact_badge(contact)
    color =
      case contact.status
        when "invited"
          "primary"
        when "active"
          "success"
        when "deleted"
          "revoked"
        else
          raise "Invalid status: #{status}"
      end

    badge(contact.status_text, color)
  end
end
