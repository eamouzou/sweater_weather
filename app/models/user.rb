class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password_digest, require: true
  has_secure_password
  has_secure_token :api_key
end
