class MoviesController < ApplicationController

  before_action :set_movie, only: [:show, :edit, :update]

  def index
    @movies = Movie.released
  end

  def show
    @review = @movie.reviews.new
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie successfully updated!"
    else
      render :edit
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie successfully created!"
    else
      render :new
    end
  end

  def destroy
    redirect_to movies_url, danger: "I'm sorry, Dave, I'm afraid I can't do that!"
    # Movie.find(params[:id]).destroy
    # redirect_to movies_url, alert: "Movie successfully deleted!"
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).
      permit(:title, :description, :rating, :total_gross, :released_on, :director, :duration, :image_file_name)
  end
end
