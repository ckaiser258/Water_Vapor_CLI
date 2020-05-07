class User < ActiveRecord::Base
    # Establish ORM relationships via ActiverRecord macros
    has_many(:consoles)
    
    # Setup required initialized attributes
    def initialize(name:, birthday:)
        super
    end

    # Also update age when birthday is updated
    def birthday=(birthday)
        super
        self.calculate_age
    end

    def calculate_age
        # Note 365.25 average days per year
        self.age = ((DateTime.now - self.birthday) / 365.25).floor
    end

    # Additional CRUD Methods: Begin

    def create_console(console_name)
        self.add_console(Console.create(name: console_name))
    end

    def add_console(console)
        self.consoles.push(console)
    end

    def add_console_by_name(console_name)
        self.consoles.push(Console.new(name: console_name))
    end

    def remove_console(console)
        console.destroy
    end

    def remove_console_by_name(console_name)
        Console.find_by_name(console_name).destroy
    end

    def add_game_to_console(console, game)
        # Adds game only if Console belongs to User
         console_in_user_library?(console) ? console.add_game(game) : "Unable to add #{game.name} to console #{console.name} because this console does not belong to you."
    end

    def add_game_by_name_to_console(console, game_name)
        # Adds game only if Console belongs to User
        console_in_user_library?(console) ? console.add_game_by_name(game_name) : "Unable to add #{game.name} to console #{console.name} because this console does not belong to you."
    end

    def add_game_by_name_to_console_by_name(console_name, game_name)
        Console.find_by_name(console_name).add_game_by_name(game_name)
    end

    def remove_game_from_console(console, game)
        # Remove game only if Console belongs to User
        console_in_user_library?(console) ? console.remove_game(game) : "Unable to remove #{game.name} from console #{console.name} because this console does not belong to you."
    end

    def remove_game_by_name_from_console(console, game_name)
        # Remove game only if Console belongs to User
        console_in_user_library?(console) ? console.remove_game_by_name(game_name) : "Unable to remove #{game.name} from console #{console.name} because this console does not belong to you."
    end

    # Additional CRUD Methods: End
    # Other Analytics Methods: Start

    def console_count
        self.consoles.count
    end

    def console_names
        self.consoles.map {|console| console.name}
    end

    # List all games in users library
    def games
        self.consoles.map{|console| console.games}.flatten
    end

    def game_names
        self.games.map{|game| game.name}
    end

    def game_and_rating(game_name)
        self.games.map{|game|
        if game_name == game.name
        return "#{game.name} - #{game.rating}"
        end}
    end

    def games_and_ratings(game_name)
        self.games.map{|game|"#{game.name} - #{game.rating}"}
    end

    def game_count
        self.games.count
    end

    def self.top_ten
        self.games.order(rating: :desc).limit(10).map{|game| "#{game.name} (Rating: #{game.rating})"}
    end

    # Returns a list of game names that self and another user have in commond
    def common_games(user)
        (self.games & user.games).map{|game| game.name}
    end

    # All user stats
    def self.stats
        self.all.map{|user| "Name: #{user.name}, Consoles: #{user.console_count}, Games: #{user.game_count}"}
    end

    # Other Analytics Methods: End
    # Helper Methods: Begin

    def console_in_user_library?(console)
        self.consoles.include?(console)
    end

    # Helper Methods: End

end