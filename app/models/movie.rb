class Movie < ActiveRecord::Base
  attr_accessor :title, :url, :provider
  # validates :title, :url, :provider, presence: true
  has_many :categories
end
