class Movie < ApplicationRecord
  def flop?
    total_gross && total_gross < 325_000_000
  end
end
