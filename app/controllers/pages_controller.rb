class PagesController < ApplicationController

  def home
   @latest = Movie.approved.sort.first(3)
   @featured = Movie.feature.approved.sort.first(3)
   @top = Movie.top.first(3)
  end

end
