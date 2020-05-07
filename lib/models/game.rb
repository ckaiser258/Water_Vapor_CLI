class Game < ActiveRecord::Base
    # Establish ORM relationships via ActiverRecord macros
    has_many(:console_games)
    has_many(:consoles, through: :console_games)

    # Additional CRUD Methods: Begin
    
    def self.all_name
        self.all.map{|game| game.name}
    end

    def self.top_ten
        self.all.order(rating: :desc).limit(10).map{|game| "#{game.name} (Rating: #{game.rating})"}
    end

    # Additional CRUD Methods: End
    
end