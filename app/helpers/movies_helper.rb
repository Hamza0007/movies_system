module MoviesHelper

  def title_titelize(title)
    return if title.blank?
    title.titleize
  end

  def button_title(val)
    prefix = action_name == 'new' ? 'Create' : 'Update'
    [prefix, val].join(' ')
  end

end
