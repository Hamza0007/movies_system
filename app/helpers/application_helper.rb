module ApplicationHelper
  def movie_index?
    params[:controller] == 'movies' && params[:action] == 'index'
  end
end
