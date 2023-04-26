class User < ApplicationRecord
  has_many :posts
  validates :email, presence: true, length: { minimum: 5, maximum: 50 }
  validates :name, presence: true, length: { minimum: 5, maximum: 50 }
  validates :auth_token, presence: true, length: { minimum: 5, maximum: 50 }
end
