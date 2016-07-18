module PagesHelper
  def movies_present?(top,latest,featured)
    return (top.present? && latest.present? && featured.present?)
  end
end
