class Subscription < ApplicationRecord

  has_many :companies, dependent: :nullify

  validates :name, :quantity_users, presence: true
end
