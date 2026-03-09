class GroupUser < ApplicationRecord
  before_validation :set_group_type
  before_destroy :abort_if_owner

  belongs_to :user
  belongs_to :group

  validates :user_id, :group_id, :group_type, :role, presence: true
  validate :user_is_uniq

  enum :role, {
    owner: "owner",
    shared: "shared"
  },
  default: :shared

  def role_text
    I18n.t("activerecord.enums.group_user.role.#{role}")
  end


  private

  def set_group_type
    return if group_type.present?

    self.group_type = group.group_type
  end

  def abort_if_owner
    return if group.allows_owner_destroy
    throw(:abort) if role == "owner"
  end

  def user_is_uniq
    errors.add(:user_id, "was already added") if group.user_ids.include?(user_id)
  end
end
