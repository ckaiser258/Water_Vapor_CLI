class CreateConsoleGames < ActiveRecord::Migration[5.2]
  def change
    create_table(:console_games) do |column|
      column.integer(:console_id)
      column.integer(:game_id)
    end
  end
end
