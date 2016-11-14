class Comment < ApplicationRecord
  belongs_to :id, class_name: 'Comment', :foreign_key => 'post_id'
end
