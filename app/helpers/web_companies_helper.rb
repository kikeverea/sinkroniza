module WebCompaniesHelper

  def web_company_type_text(type)
    I18n.t("activerecord.enums.web_company.web_company_type.#{type}")
  end
end
