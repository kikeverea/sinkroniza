require "uri"

class Credential < ApplicationRecord
  company_scoped

  belongs_to :web
  belongs_to :group, optional: true
  has_many :credential_tags, dependent: :destroy
  has_many :tags, through: :credential_tags

  validates :web, :name, :credential_type, presence: true

  enum :credential_type, {
    autologin: "autologin",
    regular: "regular",
    note: "note",
  }

  def credential_type_text
    I18n.t("activerecord.enums.credential.credential_type.#{credential_type}")
  end

  def as_json(options = nil)
    {
      name: web.name,
      logo: web.logo&.url,
      url: web.access_url,
      autologin_url: (add_query_params(web.access_url, { fromExtension: 1 }) if credential_type == "autologin"),
      encrypted_blob: encrypted_blob,
      type: credential_type
    }
  end


  private

  def add_query_params(url, new_params)
    uri = URI.parse(url)

    existing = uri.query ? URI.decode_www_form(uri.query) : []
    added = new_params.to_a.map { |k, v| [k.to_s, v.to_s] }

    uri.query = URI.encode_www_form(existing + added)
    uri.to_s
  end
end
