class HomeController < ApplicationController
  def index
    movies = Movie.all

    # TODO: まとめて書けそう
    @movie_providers = %w{youtube niconico vimeo fc2}
    @youtube_movies = movies.where(provider: "youtube").order("created_at DESC").take(4)
    @niconico_movies = movies.where(provider: "niconico").order("created_at DESC").take(4)
    @vimeo_movies = movies.where(provider: "vimeo").order("created_at DESC").take(4)
    @fc2_movies = movies.where(provider: "fc2").order("created_at DESC").take(4)

  end
end
