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
        # THIS IS BEING BROKEN BY FAKERS BIRTHDAY INPUTS, Need to troubleshoot!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        #self.calculate_age
    end

    def calculate_age
        self.age = ((Time.zone.now - self.birthday.to_time) / 1.year.seconds).floor
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

    # Other Analytics: Start

    def console_count
        self.consoles.count
    end

    # List all games in users library
    def games
        self.consoles.map{|console| console.games}.flatten
    end

    def game_count
        self.games.count
    end

    # Otehr Analytics: End

end