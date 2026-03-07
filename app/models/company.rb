class Company < ApplicationRecord
  before_create :set_creator

  belongs_to :subscription
  has_many :users

  mount_base64_uploader :logo, ImageUploader

  validates :subscription_id, :name, presence: true


  def manager_full_name
    "#{manager_name} #{manager_lastname}"
  end

  private

  def set_creator
    return if Current.user.nil?

    self.creator_user_id ||= Current.user.id
    self.creator_user_name ||= Current.user.full_name
  end
end
