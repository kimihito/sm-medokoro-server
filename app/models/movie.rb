class Movie < ActiveRecord::Base
  has_many :categories
  validates :title, :provider, :url, presence: true
  validates :url, specific_url: true
end