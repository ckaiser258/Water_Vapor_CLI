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
        x = ConsoleGame.create
        x.game = game
        x.console = self
        x.save

    end

    def add_game_by_name(game_name)
        x = ConsoleGame.create
        x.game = Game.find_by_name(game_name)
        x.console = self
        x.save
    end

    def remove_game(game)
        ConsoleGame.find_by(console_id: self.id, game_id: game.id).destroy
    end

    def remove_game_by_name(game_name)
        ConsoleGame.find_by(console_id: self.id, game_id: Game.find_by_name(game_name).id).destroy
    end

    def self.console_all_names
        self.all.map {|console| console.name}
    end

    # Additional CRUD Methods: End

end