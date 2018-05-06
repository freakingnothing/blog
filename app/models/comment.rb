class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates_presence_of :user
  validates :body, presence: true

  def find_post
    Post.find_by(id: self.post_id)
  end
end
