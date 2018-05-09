# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates_presence_of :user
  validates :body, presence: true

  def find_post
    Post.find_by(id: post_id)
  end
end
