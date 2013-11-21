class Movie < ActiveRecord::Base
  attr_accessor :title, :url, :provider
  validates :title,:provider, presence: true
  validates :url, presence:true, format: { with: /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?\Z/, on: :create}
  has_many :categories
end
