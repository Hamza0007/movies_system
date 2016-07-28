class PagesController < ApplicationController

  def home
   movie = Movie.includes(:ratings, :attachments)
   @latest = movie.approved.first(3)
   @featured = movie.feature.approved.first(3)
   @top = movie.top.approved.first(3)
  end

end
