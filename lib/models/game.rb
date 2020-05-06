class Game < ActiveRecord::Base
    # Establish ORM relationships via ActiverRecord macros
    has_many(:console_games)
    has_many(:consoles, through: :console_games)

    # Additional CRUD Methods: Begin
    
    def all_name
        Games.all.map{|game| game.name}
    end

    def top_ten
        Game.all.order(rating: :desc).limit(10).map{|game| "#{game.name} (Rating: #{game.rating})"}
    end

    # Additional CRUD Methods: End

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