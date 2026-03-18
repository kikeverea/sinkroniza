class Tag < ApplicationRecord
  company_scoped optional: true

  has_many :taggings, dependent: :destroy

  def self.ransackable_associations(_auth_object = nil)
    []
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[ name created_at ]
  end
end
