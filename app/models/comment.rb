class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :update_comments_counter

  def author=(user)
    self.user_id = user.id
  end

  def update_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
