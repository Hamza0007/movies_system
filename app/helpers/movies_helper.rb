module MoviesHelper

  def title_titelize(title)
    return if title.blank?
    title.titleize
  end
end
