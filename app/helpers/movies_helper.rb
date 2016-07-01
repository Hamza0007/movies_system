module MoviesHelper

  def title_titelize(title)
    return if title.blank?
    title.titleize
  end

  def button_title(val)
    if action_name == 'new'
      "Create #{val}"
    else
      "Update #{val}"
    end
  end

end
