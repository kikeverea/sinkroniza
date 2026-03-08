module UsersHelper

  def user_role_text(role)
    I18n.t("activerecord.enums.user.role.#{role}")
  end

  def user_status_text(status)
    I18n.t("activerecord.enums.user.status.#{status}")
  end

  def user_status_badge(user, tiny: false)
    color =
      case user.status
        when "active"
          "success"
        when "inactive"
          "warning"
        when "deleted"
          "danger"
        else
          raise "Invalid status: #{status}"
      end

    badge(user.status_text, color, classes: ("fs-6 py-2 px-3" unless tiny))
  end
end
