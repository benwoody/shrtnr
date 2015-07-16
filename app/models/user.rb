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

  def update_with_twitter(auth)
    self.name = auth.info.nickname if name.nil? || name.blank?
    self.uid = auth.uid

    save!
  end

  def linked_with_twitter?
    !(uid.nil? || uid.blank?)
  end
end
