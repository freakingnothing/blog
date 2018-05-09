# frozen_string_literal: true

class Post < ApplicationRecord
  extend FriendlyId

  friendly_id :title, use: %i[slugged finders]

  attr_accessor :state_event

  has_many :comments, dependent: :destroy

  has_many :taggings
  has_many :tags, through: :taggings

  validates :title, :body, presence: true

  after_save :trigger_state, if: :state_event

  enum status: { draft: 0, published: 1 } do
    event :publish do
      after do
        self.published_at = DateTime.now
        save
      end

      transition draft: :published
    end

    event :unpublish do
      transition published: :draft
    end
  end

  def should_generate_new_friendly_id?
    title_changed?
  end

  private

  def trigger_state
    send(state_event) if send(:"can_#{state_event}?")
  end
end
