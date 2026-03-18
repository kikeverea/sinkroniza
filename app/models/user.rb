class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  company_scoped optional: true

  after_create :add_to_group

  attr_accessor :skip_password_validation
  attr_accessor :group_id

  mount_base64_uploader :image, ImageUploader

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users

  has_one :personal_group_user, -> { joins(:group).where(groups: { group_type: :personal }) }, class_name: "GroupUser"
  has_one :personal_group, through: :personal_group_user, source: :group

  has_many :credentials, through: :groups

  has_many :emergency_contacts, foreign_key: :owner_user_id, dependent: :destroy
  has_many :emergency_contact_users, class_name: "EmergencyContact", foreign_key: :contact_user_id, dependent: :destroy
  has_many :emergency_requests, through: :emergency_contacts

  validates :name, :lastname, presence: true
  validate :company_presence

  scope :kept, -> { where.not(status: :deleted) }
  scope :discarded, -> { where(status: :deleted) }

  def password_required?
    return false if skip_password_validation
    super
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at full_name email role]
  end

  ransacker :full_name do
    Arel.sql("LOWER(CONCAT(users.name, ' ', users.lastname))")
  end

  enum :role, {
    super_admin: "super_admin",
    company_admin: "company_admin",
    user: "user"
  },
  default: :user

  enum :status, {
    active: "active",
    inactive: "inactive",
    deleted: "deleted"
  },
  default: :active

  def role_text
    I18n.t("activerecord.enums.user.role.#{role}")
  end

  def status_text
    I18n.t("activerecord.enums.user.status.#{status}")
  end

  def creatable_roles

    case role.to_sym
      when :super_admin
        %w[super_admin company_admin]
      when :company_admin
        %w[user]
      when :user
        []
      else
        raise "Invalid role: #{role}"
    end
  end

  def full_name
    "#{self.name} #{self.lastname}"
  end

  def jwt_payload
    self.jti = self.class.generate_jti
    self.save

    super.merge({
      jti: self.jti,
      usr: self.id,
    })
  end

  def as_json(_options = nil)
    super.merge(company_name: company&.name)
  end

  private

  def add_to_group
    if group_id
      GroupUser.create!(user: self, group_id: self.group_id)
    elsif role == "user"
      Group.create!(group_type: :personal, owner_id: self.id)
    end
  end

  def company_presence
    errors.add(:company_id, "El super admin no puede pertenecer a una compañía") if !company_id.nil? && role == "super_admin"
    # errors.add(:company_id, "El admin de compañía debe pertenecer a la compañía") if company_id.nil? && role == "company_admin"
    errors.add(:company_id, "Los usuarios deben pertenecer a una compañía") if company_id.nil? && role == "user"
  end
end
