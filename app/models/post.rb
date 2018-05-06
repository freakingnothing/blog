class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  enum status: { draft: 0, published: 1 } do
    event :publish do
      after do
        self.published_at = DateTime.now
        self.save
      end

      transition :draft => :published
    end
  end

  has_many :comments, dependent: :destroy
  
  has_many :taggings
  has_many :tags, through: :taggings

  validates :title, :body, presence: true

  def should_generate_new_friendly_id?
    title_changed?
  end
end
