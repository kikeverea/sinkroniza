class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  mount_base64_uploader :image, ImageUploader

  def self.ransackable_associations(auth_object = nil)
    []
    end
    
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "name", "email"]
  end

  enum role: {
      admin: "admin",
  }

  def full_name
    "#{self.name} #{self.lastname}"
  end


  def jwt_payload
    self.jti = self.class.generate_jti
    self.save

    # super isn't doing anything useful, but if the gem updates i'll want it to be safe
    super.merge({
      jti: self.jti,
      usr: self.id,
    })
  end


end
