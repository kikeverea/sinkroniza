class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  mount_base64_uploader :image, ImageUploader

  belongs_to :company, optional: true

  validates :name, :lastname, presence: true

  def self.ransackable_associations(_auth_object = nil)
    []
    end
    
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at name email]
  end

  enum :role, {
    super_admin: "super_admin",
    admin: "admin",
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
end
