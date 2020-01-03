class Review < ApplicationRecord

  STARS = (1..5).to_a

  belongs_to :movie
  belongs_to :user

  validates :comment, length: { minimum: 10 }
  validates :stars, inclusion: {in: STARS, message: "must be between 1 and 5"}

  scope :pat_n_days, ->(n) { where("created_at >= ?", n.days_ago) }

  def stars_as_percent
    (stars / 5.0) * 100.0
  end
end
