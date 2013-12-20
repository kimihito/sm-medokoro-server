class Movie < ActiveRecord::Base
  has_many :categories
  validates :title, :provider, :url, presence: true
  validates :url, specific_url: true

  scope :youtube, -> { where(provider: 'youtube') }
  scope :niconico, -> { where(provider: 'niconico') }
  scope :vimeo, -> { where(provider: 'vimeo') }
  scope :fc2, -> { where(provider: 'fc2') }
end