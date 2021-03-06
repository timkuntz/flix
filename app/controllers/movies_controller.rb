class MoviesController < ApplicationController

  before_action :set_movie, only: [:show, :edit, :update]
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

  def index
    @movies = Movie.send(movies_filter)
  end

  def show
    @review = @movie.reviews.new
    @genres = @movie.genres
    @fans = @movie.fans
    if current_user
      @favorite = current_user.favorites.find_by(movie_id: @movie.id)
    end
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
    # redirect_to movies_url, danger: "I'm sorry, Dave, I'm afraid I can't do that!"
    @movie.destroy
    redirect_to movies_url, alert: "Movie successfully deleted!"
  end

  private

  def set_movie
    @movie = Movie.find_by!(slug: params[:id])
  end

  def movie_params
    params.require(:movie).
      permit(:title, :description, :rating, :total_gross, :released_on, :director,
             :duration, :image_file_name, genre_ids: [])
  end

  def movies_filter
    if params[:filter].in? Movie::FILTERS
      params[:filter]
    else
      :released
    end
  end
end
