class ReviewsController < ApplicationController

  before_action :require_signin, except: :index
  before_action :set_movie

  def index
    @reviews = @movie.reviews
  end

  def new
    @review = @movie.reviews.new
  end

  def create
    @review = @movie.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to @movie, notice: "Thanks for your review!"
    else
      render :new
    end
  end

  def edit
    @review = @movie.reviews.find(params[:id])
  end

  def update
    @review = @movie.reviews.find(params[:id])
    if @review.update(review_params)
      redirect_to movie_reviews_path(@movie), notice: "Comment updated!"
    else
      render :edit
    end
  end

  def destroy
    @movie.reviews.find(params[:id]).destroy
    redirect_to movie_reviews_path(@movie), alert: "Comment removed!"
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def review_params
    params.require(:review).permit(:stars, :comment)
  end
end
