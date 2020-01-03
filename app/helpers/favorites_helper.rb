module FavoritesHelper
  def fav_or_unfave_button(movie, favorite = nil)
    if favorite
      button_to "♡  Unfave", movie_favorite_path(movie, favorite),
        method: :delete
    else
      button_to "♥️  Fave", movie_favorites_path(movie)
    end
  end
end
