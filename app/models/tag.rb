class Tag < ApplicationRecord
  company_scoped optional: true

  has_many :credential_tags, dependent: :destroy
  has_many :credentials, through: :credential_tags

  def self.ransackable_associations(_auth_object = nil)
    []
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[ name created_at ]
  end
end
