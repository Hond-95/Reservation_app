class User < ApplicationRecord
  has_secure_password
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  validates :password, presence: true, length:{minimum:4}, allow_nil: true
  validates :password_confirmation, {presence: true}
  validates :image, {presence: true}
  
end
