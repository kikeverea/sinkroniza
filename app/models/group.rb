class Group < ApplicationRecord
  before_create :set_creator_user

  belongs_to :company

  validates :name, :company_id, :group_type, presence: true

  enum :group_type, {
    personal: "personal",
    company: "company"
  }

  def group_type_text
    I18n.t("activerecord.enums.group.group_type.#{group_type}")
  end


  private

  def set_creator_user
    self.created_by_user_id ||= Current.user.id
  end
end
