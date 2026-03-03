class Subscription < ApplicationRecord

  validates :name, :quantity_users, presence: true
end
