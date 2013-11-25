class Movie < ActiveRecord::Base
  attr_accessor :title, :url, :provider
  validates :title,:provider, :url, presence: true
  has_many :categories
end
