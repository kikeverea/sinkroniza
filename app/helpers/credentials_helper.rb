module CredentialsHelper

  def credential_type_text(type)
    I18n.t("activerecord.enums.credential.credential_type.#{type}")
  end

end
