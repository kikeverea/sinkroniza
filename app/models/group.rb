class Group < ApplicationRecord

  company_scoped

  before_validation :set_creator_user, on: :create
  after_save :set_owner
  after_update :update_users_group_type

  attr_accessor :owner_id
  attr_accessor :allows_owner_destroy

  belongs_to :creator, class_name: "User"
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_one :owner, -> { where(role: :owner) }, class_name: "GroupUser"

  validates :group_type, :creator_id, presence: true
  validates :name, presence: true, if: -> { group_type.to_sym == :company }

  def self.ransackable_associations(_auth_object = nil)
    []
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at name]
  end

  enum :group_type, {
    personal: "personal",
    company: "company"
  },
  default: :company

  #noinspection RubyRedundantSafeNavigation
  def owner_id
    @owner_id.presence || group_users.find_by(role: :owner)&.id
  end

  def owner
    User.find(owner_id) if owner_id
  end

  def group_type_text
    I18n.t("activerecord.enums.group.group_type.#{group_type}")
  end


  private

  def set_creator_user
    self.creator ||= Current.user
  end

  #noinspection RubyRedundantSafeNavigation
  def set_owner
    return if owner_id.nil?

    current_owner = group_users.find_by(role: :owner)
    return if current_owner&.id == owner_id

    destroy_owner(current_owner)

    GroupUser.create!(user_id: owner_id, role: :owner, group: self, group_type: self.group_type)
  end

  def destroy_owner(owner)
    self.allows_owner_destroy = true
    owner&.destroy!
    self.allows_owner_destroy = false
  end

  def update_users_group_type
    return unless saved_change_to_group_type? && group_type.present?

    group_users.each { |user| user.update!(group_type: group_type) }
  end
end
