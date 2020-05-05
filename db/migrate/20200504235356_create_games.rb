class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table(:games) do |column|
      column.string(:name)
      column.datetime(:release_year)
      column.string(:age_rating)
      column.string(:genre)
      column.boolean(:multiplayer)
      column.text(:summary)
      column.string(:main_character)
    end
  end
end
