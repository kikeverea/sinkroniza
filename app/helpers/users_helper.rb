module UsersHelper

  def user_role_text(role)
    I18n.t("activerecord.enums.user.role.#{role}")
  end

  def user_status_text(status)
    I18n.t("activerecord.enums.user.status.#{status}")
  end

end
