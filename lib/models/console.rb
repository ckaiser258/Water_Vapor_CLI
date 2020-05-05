class Console < ActiveRecord::Base
    # Establish ORM relationships via ActiverRecord macros
    belongs_to(:user)
    has_many(:console_games)
    has_many(:games, through: :console_games)

    # Setup required initialized attributes
    def initialize(name:)
        super
    end

    # Additional CRUD Methods: Start

    def add_game(game)
        ConsoleGame.create(console_id: self.id, game_id: game.id)
    end

    # not working right, cant see it in self.games after its added.
    def add_game_by_name(game_name)
        ConsoleGame.create(console_id: self.id, game_id: Game.find_by_name(game_name).id)
    end

    def remove_game(game)
        ConsoleGame.find_by(console_id: self.id, game_id: game.id).destroy
    end

    def remove_game_by_name(game_name)
        ConsoleGame.find_by(console_id: self.id, game_id: Game.find_by_name(game_name).id).destroy
    end

    # Additional CRUD Methods: End

end