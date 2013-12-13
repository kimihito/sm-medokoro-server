class HomeController < ApplicationController
  def index
    @movies = Movie.all
  end

  def all_movies
    # @movie = Movie.where(provider: "vimeo").take(25)
    @movie = Movie.where(provider: "niconico").take(25)
    render json: @movie, callback: params[:callback]
  end
end
