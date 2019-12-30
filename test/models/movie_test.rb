require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "#flop is true" do
    movie = Movie.new(total_gross: 324_999_999)
    def movie.average_stars; 3; end
    49.times { movie.reviews << Review.new()}
    assert movie.flop?
  end

  test "#flop is false" do
    movie = Movie.new(total_gross: 325_000_000)
    assert !movie.flop?
  end

  test "#flop is false because cult classic" do
    movie = Movie.new(total_gross: 324_999_999)
    def movie.average_stars; 4; end
    50.times { movie.reviews << Review.new()}
    assert !movie.flop?
  end
end
