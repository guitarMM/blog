class Comment < ApplicationRecord
  belongs_to :post, class_name: "Comment", :foreign_key: "post_id"
end
