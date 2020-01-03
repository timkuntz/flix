class FavoritesController < ApplicationController

  before_action :require_signin
  before_action :set_movie

  def create
    # @movie.favorites.create!(user: current_user)
    @movie.fans << current_user unless @movie.fans.include?(current_user)
    redirect_to @movie
  end

  def destroy
    favorite = current_user.favorites.find(params[:id])
    favorite.destroy if favorite
    redirect_to @movie
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
