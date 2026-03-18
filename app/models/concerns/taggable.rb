module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :taggings, as: :taggable, dependent: :destroy
    has_many :tags, through: :taggings
    accepts_nested_attributes_for :tags, allow_destroy: true

    ransacker :email_addresses do
      Arel.sql(
        "(SELECT GROUP_CONCAT(emails.email SEPARATOR ', ')
            FROM emails
            WHERE emails.emailable_id = #{self.table_name}.id
              AND emails.emailable_type = '#{self.name}')"
      )
    end
  end
end