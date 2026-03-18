class Company < ApplicationRecord
  before_validation :set_creator, on: :create
  before_save :invalidate_if_no_subscription
  after_create :set_manager

  attr_accessor :manager_attributes

  belongs_to :subscription, optional: true
  belongs_to :creator, class_name: "User"
  has_one :manager, -> { where(role: :company_admin) }, class_name: "User"
  has_many :employees, -> { where(role: :user) }, class_name: "User"
  has_many :users, dependent: :destroy

  mount_base64_uploader :logo, ImageUploader

  validates :name, presence: true
  validates :subscription_id, presence: true, on: :create
  validates :name, uniqueness: true

  def self.ransackable_associations(_auth_object = nil)
    %w[ subscription creator manager ]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[ name legal_name tax_id created_at status ]
  end

  enum :status, {
    active: "active",
    inactive: "inactive"
  },
  default: :active

  def status_text
    I18n.t("activerecord.enums.company.status.#{status}")
  end

  def full_address
    address.present? && cp.present? ? "#{address}, #{cp}" : address
  end

  def can_add_user?
    users.kept.count < subscription.max_users
  end

  private

  def set_creator
    return if Current.user.nil?
    self.creator ||= Current.user
  end

  def invalidate_if_no_subscription
    return unless persisted? && will_save_change_to_subscription_id?

    self.status = :inactive if subscription_id.nil?
  end

  def set_manager
    if manager
      manager.update!(company: self)
    elsif manager_attributes.present?
      manager = User.new(manager_attributes)
      manager.skip_password_validation = true
      manager.role = :company_admin
      manager.company = self
      manager.save!
    end
  end
end
