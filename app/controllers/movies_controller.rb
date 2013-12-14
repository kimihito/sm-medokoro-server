class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
    respond_to do |format|
      format.html
      format.json {render json: @movie}
    end
  end

  def random
    @movie = Movie.first(offset: rand(Movie.count) )
    respond_to do |format|
      format.html {render :show, notice: "ランダム再生で移動されました"}
      format.json {render json: @movie, action: :show}
    end
  end
end