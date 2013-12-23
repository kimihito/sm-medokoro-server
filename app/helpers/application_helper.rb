module ApplicationHelper
  def search_date
    if Date.valid_date?(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    else
      Date.today
    end
  end
end
