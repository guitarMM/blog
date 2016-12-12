class Post < ApplicationRecord
  paginates_per 10

  belongs_to :user
  has_many :comments

  scope :latest, -> { order("update_at DESC") }
  before_update ->{ logger.info 'before_update' }
  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true
end
