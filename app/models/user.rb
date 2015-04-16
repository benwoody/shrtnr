require 'securerandom'

class User < ActiveRecord::Base
  has_secure_password

  has_many :links

  validates_uniqueness_of :email

  def self.from_twitter(auth)
    create! do |user|
      user.name = auth.info.nickname
      user.uid = auth.uid
      user.password = SecureRandom.hex
    end
  end

end
