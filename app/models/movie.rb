require 'nokogiri'
require 'open-uri'

class Movie < ActiveRecord::Base
  attr_accessor :title, :url, :provider
  validates :title, :provider, :url, presence: true
  validates :url,  format: { with: /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/(\w*?)\Z/}
  has_many :categories

  def get_youtube_data
    return unless new_record?
    data = Hash.new
    uri = URI("https://gdata.youtube.com/feeds/api/standardfeeds/JP/most_recent?time=today&v=2").read
    docs = Nokogiri::XML(uri)
    entry = docs.search("entry").text
    entry.each_with_index do |attr,index|
      media = attr.xpath("media:group")
      data[index] = {yt: {title: attr.search("title").text}}
      data[index] = {yt: {thumbnail: media.xpath("media:thumbnail").attr("url")}}
      data[index] = {yt: {thumbnail: media.xpath("yt:videoid").text}}
      data[index] = {yt: {category: media.xpath("media:category").text}}
    end
  end

end
