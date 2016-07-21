class PagesController < ApplicationController

  def home
   @latest = Movie.approved.first(3)
   @featured = Movie.feature.approved.first(3)
   @top = Movie.top.approved.first(3)
  end

end
