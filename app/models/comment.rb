class Comment < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  after_save :update_comments_counter

  def author=(user)
    self.user_id = user.id
  end

  def update_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
