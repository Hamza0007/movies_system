module ApplicationHelper
  def movie_index?
    params[:controller] == 'movies' && params[:action] == 'index'
  end

  def movie_cast(movie)
    movie.actors.pluck(:name).join(', ')
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

end
