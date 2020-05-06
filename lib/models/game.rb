class Game < ActiveRecord::Base
    # Establish ORM relationships via ActiverRecord macros
    has_many(:console_games)
    has_many(:consoles, through: :console_games)

    def add_game(name)
        first_release_date = ""
        rating = ""
        summary = ""
        GamesApi.get_games.each do |game|
            if name == game["name"]
                first_release_date = game["first_release_date"]
                rating = game["rating"]
                summary = game["summary"]
            end
        end
        Game.create(name: name, first_release_date: first_release_date, rating: rating, summary: summary)
    end
    
end