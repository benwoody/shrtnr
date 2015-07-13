class User < ActiveRecord::Base
  has_secure_password

  has_many :links

  validates_uniqueness_of :email

  # Comment!
end
