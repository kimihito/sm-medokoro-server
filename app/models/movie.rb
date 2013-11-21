require 'net/http'
require 'uri'

class Movie < ActiveRecord::Base
  attr_accessor :title, :url, :provider
  validates :title,:provider, :url, presence: true
  validates :url,  format: { with: /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?\Z/, on: :create}
  has_many :categories

  def get_youtube_data
    return unless new_record?


  end
end
