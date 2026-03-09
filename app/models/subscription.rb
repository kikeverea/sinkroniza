class Subscription < ApplicationRecord

  has_many :companies, dependent: :nullify

  validates :name, :max_users, presence: true
end
