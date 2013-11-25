class Movie < ActiveRecord::Base
  has_many :categories
  validates :title, :provider, :url, presence:true
end
