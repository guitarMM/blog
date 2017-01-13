class Post < ApplicationRecord
  paginates_per 10

  belongs_to :user
  has_many :comments

  before_update ->{ logger.info 'before_update' }
  validates :title, presence: true, length: { minimum: 1 }
  validates :body, presence: true
end
