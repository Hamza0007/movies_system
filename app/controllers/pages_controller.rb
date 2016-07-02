class PagesController < ApplicationController

  def home
   @latest = Movie.latest.first(3)
   @featured = Movie.feature.first(3)
  end

end
