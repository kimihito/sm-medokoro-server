FactoryGirl.define do
  factory :movie do
    title "hoge-movie-title"
    url "http://www.youtube.com/watch?v=x3rjxpQ0EP4"
    provider "youtube"
  end

  factory :invalid_url, class: Movie do
    title "hoge-movie-title"
    url "http://www.google.com/"
    provider "twitter"
  end

  # TODO: title まとめられる

  factory :url_youtube, class: Movie do
    title "hoge-movie-youtube"
    url "http://www.youtube.com/watch?v=x3rjxpQ0EP4"
    provider "youtube"    
  end

  factory :url_niconico, class: Movie do
    title "hoge-movie-niconico"
    url "http://www.nicovideo.jp/watch/sm22352355"
    provider "niconico"    
  end

  factory :url_vimeo, class: Movie do
    title "hoge-movie-vimeo"
    url "https://vimeo.com/79836732"
    provider "vimeo"    
  end

  factory :url_fc2, class: Movie do
    title "hoge-movie-vimeo"
    url "http://video.fc2.com/content/20131024uzdMx6SH&t_aswell"
    provider "fc2"    
  end
end