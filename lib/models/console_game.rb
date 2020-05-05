class ConsoleGame < ActiveRecord::Base
        # Establish ORM relationships via ActiverRecord macros
        belongs_to(:console)
        belongs_to(:game)
end