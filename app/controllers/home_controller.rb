class HomeController < ApplicationController
  def index
    movies = Movie.all

    # TODO: まとめて書けそう
    @movie_providers = %w{youtube niconico vimeo fc2}
    @youtube_movies = movies.where(provider: "youtube").order("created_at DESC")
    @niconico_movies = movies.where(provider: "niconico").order("created_at DESC")
    @vimeo_movies = movies.where(provider: "vimeo").order("created_at DESC")
    @fc2_movies = movies.where(provider: "fc2").order("created_at DESC")

  end

  def all_movies
    # @movie = Movie.where(provider: "vimeo").take(25)
    @movie = Movie.where(provider: "niconico").take(25)
    render json: @movie, callback: params[:callback]
  end
end
