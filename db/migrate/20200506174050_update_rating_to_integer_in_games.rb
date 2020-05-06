class UpdateRatingToIntegerInGames < ActiveRecord::Migration[5.2]
  def change
    change_column(:games, :rating, :integer)
  end
end
