module GroupsHelper
  def group_type_text(type)
    I18n.t("activerecord.enums.group.group_type.#{type}")
  end
end
