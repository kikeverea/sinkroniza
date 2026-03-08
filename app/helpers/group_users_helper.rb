module GroupUsersHelper
  def group_user_role_text(role)
    I18n.t("activerecord.enums.group_user.role.#{role}")
  end

  def group_user_badge(group_user)
    badge(group_user.role_text, group_user.role == "owner" ? "primary" : "success")
  end
end