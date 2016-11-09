class AddBodyToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :body, :string
  end
end
