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
    entry = parse_url_to_xml("youtube").search("entry")
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
    items = parse_url_to_xml("niconico").search("item")[0..24]
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

  def get_vimeo_data
    vm_data = Hash.new
    items = parse_url_to_xml("vimeo").search("item")
    items.each_with_index do |attr, index|
      url = attr.search("link").text
      title = attr.search("title").text
      thumbnail_url = attr.xpath("media:content").xpath("media:thumbnail").attr("url").text
      videoid = url.split("/").last
      tags = []
      attr.search("description").each do |el|
        html = Nokogiri::HTML.parse(el.children.text)
        html.search("body").search("p").children.each do |e|
          if e.attr("href").class != NilClass && e.attr("href").include?("tag:")
            tag = e.attr("href").split("/").last
            tags << tag.split(":").last
          end
        end
      end
      vm_data[index] = {vm:
                        {
                          title: title,
                          url:   url,
                          thumbnail: thumbnail_url,
                          videoid: videoid,
                          category: tags,
                          provider: "niconico"
                        }
                       }
    end
  end

  def get_fc2_data
    fc_data = Hash.new
    items = parse_url_to_xml("fc2").search("item")
    items.each_with_index do |attr, index|
      url = attr.search("link").text
      videoid = url.split("=").last
      thumbnail_url = attr.xpath("dc:image").text
      title = attr.search("title").text
      fc_data[index] = {fc:
                        {
                          title: title,
                          url: url,
                          videoid: videoid,
                          thumbnail: thumbnail_url,
                          category: "",
                          provider: "fc2"
                        }
                       }
    end
  end

  private

  def parse_url_to_xml(provider)
    uri = URI(provider_to_url(provider)).read
    docs = Nokogiri::XML(uri)
  end

  def provider_to_url(provider)
    provider.to_s unless provider.class == "String"
    {
      youtube:  "https://gdata.youtube.com/feeds/api/standardfeeds/JP/most_recent?time=today&v=2",
      niconico: "http://www.nicovideo.jp/ranking/view/daily?rss=2.0",
      vimeo:    "http://vimeo.com/channels/staffpicks/videos/rss",
      fc2:      "http://video.fc2.com/feed_popular.php?m=recent"
    }[provider.to_sym]
  end
end
