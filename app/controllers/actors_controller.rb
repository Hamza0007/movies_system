class ActorsController < ApplicationController
  before_action :set_actor, only: [:show]

  def show
  end

  def set_actor
    @actor = Actor.find_by_id(params[:id])
    redirect_to root_path, notice: 'Actor does not exists' unless @actor.present?
  end

end
