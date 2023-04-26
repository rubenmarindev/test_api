class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { minimum: 5, maximum: 50 }
  validates :content, presence: true, length: { minimum: 20, maximum: 1000 }
  validates :published, inclusion: { in: [true, false] }
end
