class MoviesController < ApplicationController
  before_action :validate_date, only: :date_order

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
    start_date = @params_date.yesterday + 9.hour
    end_date = start_date + 1.day
    @movies = Movie.where(created_at: start_date..end_date).order("created_at DESC")

    respond_to do |format|
      if @movies.empty?
        format.html {render template: 'errors/empty'}
      else
        format.html
        format.json {render json: @movies}
      end
    end
  end

  private
  def validate_date
    begin
      @params_date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      #未来の日付のとき
      if @params_date > Date.today
        render 'errors/future_date.html', status: 404
      end
    rescue
      #日付として存在しないとき
      render 'errors/not_exist_date.html', status: 404
    end
  end
end