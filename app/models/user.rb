# frozen_string_literal: true

class User < ApplicationRecord
  extend FriendlyId
  
  friendly_id :nickname, use: %i[slugged finders]

  has_secure_password

  attr_accessor :current_password

  has_many :comments

  validates :nickname, presence: true,
                       uniqueness: true,
                       length: { minimum: 4 }
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, presence: true,
                       length: { minimum: 6 }
  # validates :admin_role, inclusion: { in: %w(true false) }

  validate :current_password_is_correct, on: :update

  before_create :generate_confirmation_token

  def email_active
    self.email_confirmed = true
    self.confirmation_token = nil
  end

  def admin?
    admin_role == true
  end

  def current_password_is_correct
    if User.find(id).authenticate(current_password) == false
      errors.add(:current_password, "is incorrect.")
    end
  end

  private

  def generate_confirmation_token
    if confirmation_token.blank?
      self.confirmation_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
