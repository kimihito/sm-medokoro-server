module ApplicationHelper
  # TODO: もっと綺麗に書ける
  def date
    today = Date.today
    date = Hash.new
    if params[:year] && params[:month] && params[:day]
      date[:year] = params[:year]
      date[:month] = params[:month]
      date[:day] = params[:day]
    else
      date[:year] = today.year
      date[:month] = today.month
      date[:day] = today.day
    end
    date
  end

  def start_date_list
  # TODO: 毎回取得する必要はない
    start_date = Hash.new
    first_movie_date = Movie.first.created_at

    start_date[:year] = first_movie_date.year
    start_date[:month] = first_movie_date.month
    start_date[:day] = first_movie_date.day
  end

  def end_date_list
  # TODO: もっと綺麗に書ける
    end_date = Hash.new
    last_movie_date = Movie.last.created_at
    start_date[:year] = last_movie_date.year
    start_date[:month] = last_movie_date.month
    start_date[:day] = last_movie_date.day
  end
end
