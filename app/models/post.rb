class Post < ApplicationRecord
  has_many :comments
  paginates_per 10
  validates :title, presence: true, length: { minimum: 5 }
end
