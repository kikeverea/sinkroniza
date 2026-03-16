class SubscriptionPlan < ApplicationRecord

  has_many :companies, dependent: :nullify

  validates :name, :max_users, presence: true


  def self.ransackable_associations(_auth_object = nil)
    []
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[ name status created_at ]
  end
end
