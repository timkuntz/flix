class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update(movie_params)
    redirect_to @movie
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.create(movie_params)
    redirect_to @movie
  end

  def destroy
    Movie.find(params[:id]).destroy
    redirect_to movies_url
  end

  private

  def movie_params
    params.require(:movie).
      permit(:title, :description, :rating, :total_gross, :released_on)
  end
end