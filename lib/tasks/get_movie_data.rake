require 'nokogiri'
require 'open-uri'
namespace :get_movie_data do
  desc "各動画サイトから動画のデータをとってくる"

  task :youtube => :environment do
    YOUTUBE_DAIRY_RECENT_MOVIES_URL = 'https://gdata.youtube.com/feeds/api/standardfeeds/JP/most_recent?time=today&v=2'
    youtube_uri = URI(YOUTUBE_DAIRY_RECENT_MOVIES_URL).read 
    youtube_entries = Nokogiri::XML(youtube_uri).search("entry") 
    youtube_entries.each do |entry|
      media     = entry.xpath("media:group")
      url       = media.xpath("media:player").attr("url").text.gsub(/&feature=youtube_gdata_player$/,"")
      thumbnail = media.xpath("media:thumbnail").attr("url").value
      videoid   = media.xpath("yt:videoid").text
      # category  = media.xpath("media:category").text
      title     = entry.search("title").text
      provider  = "youtube"
      Movie.create(title: title, url: url, thumbnail: thumbnail, videoid: videoid, provider: provider)
    end
  end


end
