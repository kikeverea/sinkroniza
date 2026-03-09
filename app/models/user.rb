class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  after_create :add_to_group, if: -> { group_id.present? }

  attr_accessor :skip_password_validation
  attr_accessor :group_id

  mount_base64_uploader :image, ImageUploader

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  belongs_to :company, optional: true
  has_many :emergency_contacts, foreign_key: :owner_user_id, dependent: :destroy
  has_many :emergency_contact_users, class_name: "EmergencyContact", foreign_key: :contact_user_id, dependent: :destroy
  has_many :emergency_requests, through: :emergency_contacts

  validates :name, :lastname, presence: true

  scope :kept, -> { where.not(status: :deleted).accessible_by(Current.ability) }
  scope :discarded, -> { where(status: :deleted).accessible_by(Current.ability) }

  def password_required?
    return false if skip_password_validation
    super
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end
    
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at name email]
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


  private

  def add_to_group
    GroupUser.create!(user: self, group_id: self.group_id)
  end
end
