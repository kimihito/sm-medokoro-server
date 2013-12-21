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
    year = params[:year].to_i
    month = params[:month].to_i
    day = params[:day].to_i

    # 日付のチェック
    date = Date.valid_date?(year, month, day) ? Date.new(year, month, day) : Date.today
    start_date = date.yesterday + 9.hour
    end_date = start_date + 1.day
    @movies = Movie.where(created_at: start_date..end_date).order("created_at DESC")
    respond_to do |format|
      format.html
      format.json {render json: @movies}
    end
  end

  def provider_order
    # TODO: 動画サイトごとのページを表示する
    @movies = Movie.where(provider: params[:provider])
    respond_to do |format|
      format.html
      format.json {render json: @movies }
    end
  end

  private
  def validate_date
    #日付として存在しないとき
    begin
      params_date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      if params_date > Date.today
        render 'public/4044.html', status: 404
      end
    rescue
      render 'public/404.html', status: 404
    end
  end
end