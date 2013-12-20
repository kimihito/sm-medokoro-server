class HomeController < ApplicationController
  def index
    # TODO: できればジャンルごとで分けたほうが見る側としてはいい
    # TODO: アクセスした日でいいのか問題あります。
    start_date = Date.today + 9.hours
    end_date   = start_date + 1.day
    movies     = Movie.where(created_at: start_date..end_date).order('created_at DESC')

    # TODO: まとめて書けそう
    @provider_movies = {}
    providers = %w{youtube niconico vimeo fc2}
    providers.each do |proivder|
      @provider_movies[proivder] = movies.where(provider: proivder).limit(4)
    end
  end
end