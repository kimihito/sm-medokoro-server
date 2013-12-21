class HomeController < ApplicationController
  def index
    start_date = Date.today + 9.hours
    end_date   = start_date + 1.day
    @movies     = Movie.where(created_at: start_date..end_date).order('created_at DESC')
    end
  end
end