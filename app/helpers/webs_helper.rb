module WebsHelper

  def web_status_text(status)
    I18n.t("activerecord.enums.web.status.#{status}")
  end
end
