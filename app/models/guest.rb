class Guest < ApplicationRecord
  validates :full_name, :email, presence: true
  validates :email, uniqueness: { message: I18n.t('devise.failure.invited') }, allow_blank: true

  has_many :comments, as: :commenter
  has_many :notifications, as: :recipient
  has_many :guests_projects
  has_many :projects, through: :guests_projects

  strip_attributes

  def first_name
    full_name.split(' ').first
  end

  def avatar_url
    '/assets/guest-icon.png'
  end
end
