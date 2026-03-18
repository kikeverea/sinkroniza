class Subscription < ApplicationRecord
  before_create :set_status
  before_destroy :set_companies_inactive

  has_many :companies

  validates :name, :max_users, presence: true

  enum :status, {
    active: "active",
    inactive: "inactive"
  }

  def self.ransackable_associations(_auth_object = nil)
    []
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[ name status created_at ]
  end

  def status_text
    I18n.t("activerecord.enums.subscription.status.#{status}")
  end


  private

  def set_status
    self.status = price.nil? || price <= 0 ? :inactive : :active
  end

  def set_companies_inactive
    companies.each { |company| company.update!(subscription: nil, status: :inactive) }
  end
end
