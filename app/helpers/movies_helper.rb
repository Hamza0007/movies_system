module MoviesHelper

  def title_titelize(title)
    return if title.blank?
    title.titleize
  end

  def button_title(val)
    prefix = action_name == 'new' ? 'Create' : 'Update'
    [prefix, val].join(' ')
  end

  def date_display(date)
    if date.present?
      date_array = date.to_s.split('-')
      [date_array[1], date_array[2], date_array[0]].join('-')
    end
  end

end
