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
    puts "save yotube daily recent popular movies"
  end

  task :niconico => :environment do
    NICOVIDEO_DAIRY_RANLING_URL = 'http://www.nicovideo.jp/ranking/view/daily?rss=2.0'
    niconico_uri = URI(NICOVIDEO_DAIRY_RANLING_URL).read
    niconico_items = Nokogiri::XML(niconico_uri).search("item")[0..24]
    niconico_items.each do |item|
      url = item.search("link").text
      videoid = url.split("/").last
      niconico_video_data_uri = URI("http://ext.nicovideo.jp/api/getthumbinfo/#{videoid}")
      nc_docs = Nokogiri::XML(niconico_video_data_uri.read)
      thumbnail = nc_docs.search("thumbnail_url").text
      #category = nc_docs.search("tags").search("tag").children.first.text
      title = nc_docs.search("title").text
      provider = "niconico"
      Movie.create(title: title, url: url, thumbnail: thumbnail, videoid: videoid, provider: provider)
    end
    puts "save movies of niconico douga daily ranking top 25"
  end

  task :vimeo => :environment do
    #デイリーランキングがなく、そこを補完する機能でこのチャンネルにしなよってフォーラムに書いてあったと思う。 
    VIMEO_STAFFPICK_CHANNEL_URL = 'http://vimeo.com/channels/staffpicks/videos/rss'
    vimeo_uri = URI(VIMEO_STAFFPICK_CHANNEL_URL).read
    vimeo_items = Nokogiri::XML(vimeo_uri).search("item")
    vimeo_items.each do |item|
      url = item.search("link").text
      title = item.search("title").text
      thumbnail = item.xpath("media:content").xpath("media:thumbnail").attr("url").text
      videoid = url.split("/").last
      provider = "vimeo"
      Movie.create(title: title, url: url, thumbnail: thumbnail, videoid: videoid, provider: provider)
    end
    puts "save vimeo movies of staffpick channel "
  end

  task :fc2 => :environment do
    FC2_RECENT_POPULAR_MOVIES_URL = "http://video.fc2.com/feed_popular.php?m=recent"
    fc2_uri = URI(FC2_RECENT_POPULAR_MOVIES_URL).read
    fc2_items = Nokogiri::XML(fc2_uri).search("item")
    fc2_items.each do |item|
      url = item.search("link").text 
      videoid = url.split("=").last
      thumbnail = item.xpath("dc:image").text
      title = item.search("title").text 
      provider = "fc2"
      Movie.create(title: title, url: url, thumbnail: thumbnail, videoid: videoid, provider: provider)
    end
    puts "save recent popular movies in video.fc2"
  end

end
