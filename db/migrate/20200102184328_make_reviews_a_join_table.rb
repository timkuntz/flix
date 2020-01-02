class MakeReviewsAJoinTable < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :user_id, :integer
    Review.all.each do |review|
      if user = User.find_by_name(review.name)
        review.update(user_id: user.id)
      end
    end
    remove_column :reviews, :name, :string
  end
end
