require 'securerandom'

class User < ActiveRecord::Base
  has_secure_password

  has_many :links

  #validates :name,  presence: true, length: { maximum: 50 }

  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  #validates :email, presence: true, length: { maximum: 255 },
  #  format: { with: VALID_EMAIL_REGEX },
  #  uniqueness: {case_sensitive: false}

  #validates :password, length: { minimum: 7 }, allow_blank: true

  validates_uniqueness_of :email

  def self.from_twitter(auth)
    create! do |user|
      user.name = auth.info.nickname
      user.uid = auth.uid
      user.password = SecureRandom.hex
    end
  end
end
