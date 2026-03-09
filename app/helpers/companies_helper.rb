module CompaniesHelper

  def company_status_text(status)
    I18n.t("activerecord.enums.company.status.#{status}")
  end

  def company_status_badge(company)
    badge(company.status_text, company.status == "active" ? "success" : "warning")
  end
end

