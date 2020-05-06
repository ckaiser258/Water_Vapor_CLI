class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table(:games) do |column|
      column.string(:name)
      column.datetime(:first_release_date)
      column.string(:rating)
      column.text(:summary)
    end
  end
end
