module ReportedReviewsHelper
  def button_name(val)
    prefix = action_name == 'show' ? 'Create' : 'Update'
    [prefix, val].join(' ')
  end
end
