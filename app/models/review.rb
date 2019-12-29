class Review < ApplicationRecord

  STARS = (1..5).to_a
  
  belongs_to :movie

  validates :name, presence: true
  validates :stars, inclusion: {in: STARS, message: "must be between 1 and 5"}
  validates :comment, length: { minimum: 10 }
end
