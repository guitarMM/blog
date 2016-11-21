class Post < ApplicationRecord
  has_many :comments
  paginates_per 10
end
