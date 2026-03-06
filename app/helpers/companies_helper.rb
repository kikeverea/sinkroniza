module CompaniesHelper

  def companies_status_text(status)
    I18n.t("activerecord.enums.web.company.#{status}")
  end
end
