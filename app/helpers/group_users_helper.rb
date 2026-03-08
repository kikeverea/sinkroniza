module GroupUsersHelper
  def group_user_role_text(role)
    I18n.t("activerecord.enums.group_user.role.#{role}")
  end

  def group_user_badge(group_user)
    color = group_user.role == "owner" ? "primary" : "success"
    "<span class='badge text-white text-bg-#{color}'>#{group_user.role_text}</span>".html_safe
  end
end