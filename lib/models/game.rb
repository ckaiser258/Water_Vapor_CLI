class Game < ActiveRecord::Base
    # Establish ORM relationships via ActiverRecord macros
    has_many(:console_games)
    has_many(:consoles, through: :console_games)

    # Setup required initialized attributes
    def initialize(name:)
        super
    end
    
end