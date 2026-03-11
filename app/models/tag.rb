class Tag < ApplicationRecord
  belongs_to :company

  has_many :credential_tags, dependent: :destroy
  has_many :credentials, through: :credential_tags

  def self.ransackable_associations(_auth_object = nil)
    []
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[ name created_at ]
  end
end
