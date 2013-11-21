class Movie < ActiveRecord::Base
  attr_accessor :title, :url, :provider
  has_many :categories
end
