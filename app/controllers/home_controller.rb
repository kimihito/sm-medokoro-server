class HomeController < ApplicationController
  def index
    start_date = Date.yesterday + 9.hours
    end_date   = start_date + 1.day
    @movies    = Movie.where(created_at: start_date..end_date).order('created_at DESC')
    respond_to do |format|
      if @movies.empty?
        format.html {render template: 'errors/empty'}
      else
        format.html
      end
      format.json{render json: @movies}
    end
  end

  def all_movies
    start_date = Date.yesterday + 9.hours
    end_date   = start_date + 1.day
    @all_movies = Movie.where(created_at: start_date..end_date).order('created_at DESC')
    respond_to do |format|
      format.json{render json: @all_movies}
    end
  end
end