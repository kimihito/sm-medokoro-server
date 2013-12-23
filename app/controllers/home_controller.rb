class HomeController < ApplicationController
  def index
    start_date = Date.yesterday + 9.hours
    end_date   = start_date + 1.day
    @movies    = Movie.where(created_at: start_date..end_date).order('created_at DESC')
    respond_to do |format|
      if @movies.empty?
        format.html {render template: 'errors/empty'}
      end
      format.html
    end
  end
end