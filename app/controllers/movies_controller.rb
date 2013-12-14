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

  def date_order
    year = params[:year]
    month = params[:month]
    day = params[:day]
    date = Time.new(year, month, day)
    @start_date = date + 9.hour
    @end_date = @start_date + 1.day
    @movies = Movie.where("created_at >= ? and created_at < ?", @start_date, @end_date).order("created_at DESC");
    respond_to do |format|
      format.html
      format.json {render json: @movies}
    end

  end
end