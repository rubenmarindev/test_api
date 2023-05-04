class User < ApplicationRecord
  has_many :posts
  validates :email, presence: true, length: { minimum: 5, maximum: 50 }
  validates :name, presence: true, length: { minimum: 5, maximum: 50 }
  validates :auth_token, presence: true, length: { minimum: 5, maximum: 50 }

  after_initialize :generate_auth_token

  def generate_auth_token
    unless auth_token.present?
      self.auth_token = TokenGenerationService.generate
    end
  end
end
