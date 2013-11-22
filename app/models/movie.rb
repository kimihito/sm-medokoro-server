require 'nokogiri'
require 'open-uri'
require 'rexml/document'

class Movie < ActiveRecord::Base
  attr_accessor :title, :url, :provider
  validates :title, :provider, :url, presence: true
  validates :url,  format: { with: /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/(\w*?)\Z/}
  has_many :categories

  def get_youtube_data
    yt_data = Hash.new
    uri = URI("https://gdata.youtube.com/feeds/api/standardfeeds/JP/most_recent?time=today&v=2").read
    docs = Nokogiri::XML(uri)
    entry = docs.search("entry")
    entry.each_with_index do |attr,index|
      media = attr.xpath("media:group")
      yt_data[index] = {yt:
                      {
                        title: attr.search("title").text,
                        url: media.xpath("media:player").attr("url").text.gsub(/&feature=youtube_gdata_player$/,""),
                        thumbnail: media.xpath("media:thumbnail").attr("url").value,
                        videoid: media.xpath("yt:videoid").text,
                        category: media.xpath("media:category").text,
                        provider: "youtube"
                      }
                    }
    end
  end

  def get_niconico_data
    nc_data = Hash.new
    uri = URI("http://www.nicovideo.jp/ranking/view/daily?rss=2.0").read
    docs = Nokogiri::XML(uri)
    items = docs.search("item")[0..24]
    items.each_with_index do |attr,index|
      url = attr.search("link").text
      videoid = url.split("/").last
      nc_uri = URI("http://ext.nicovideo.jp/api/getthumbinfo/#{videoid}")
      nc_docs = Nokogiri::XML(nc_uri.read)
      thumbnail_url = nc_docs.search("thumbnail_url").text
      category = nc_docs.search("tags").search("tag").children.first.text
      title = nc_docs.search("title").text

      nc_data[index] = {nc:
                      {
                        title: title,
                        url:   url,
                        thumbnail: thumbnail_url,
                        videoid: videoid,
                        category: category,
                        provider: "niconico"
                      }
                    }
    end
  end


end
