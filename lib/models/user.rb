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
        # 31557600 is the seconds per average year of 365.25 days
        self.age = ((Time.now - self.birthday)/31557600).floor
    end

    # Additional CRUD Methods: Begin

    def create_console(console_name)
        Console.create(console_name)
        self.add_console
    end

    def add_console(console)
        self.consoles.push()
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
        console.add_game(game)
    end

    def add_game_by_name_to_console(console, game_name)
        console.add_game_by_name(game_name)
    end

    def remove_game_from_console(console, game)
        console.remove_game(game)
    end

    def remove_game_by_name_from_console(console, game_name)
        console.remove_game_by_name(game_name)
    end

    # Additional CRUD Methods: End

    # List all games in users library
    def games
        self.consoles.map{|console| console.games}.flatten
    end

end