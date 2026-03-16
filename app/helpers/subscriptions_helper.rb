module SubscriptionsHelper

  def subscription_status_text(status)
    I18n.t("activerecord.enums.subscription.status.#{status}")
  end

  def subscription_status_badge(subscription)
    badge(subscription.status_text, subscription.status == "active" ? "success" : "warning")
  end
end
