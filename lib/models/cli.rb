class CommandLineInterface
    def login 
        puts "\nWelcome to Water Vapor, please login by typing your name:"
        puts "(If you'd like to see a list of user names, type 'Users')\n"
        input = gets.chomp
        user = nil
        while !user
            if input == "Users"
                puts "\nAvalible Users: \n-------------------------------------------------- \n"
                puts User.stats
                input = gets.chomp
            elsif User.find_by_name(input)
                user = User.find_by_name(input)
            else
                puts "We cannot find that account, please re-enter name.\n"
                input = gets.chomp
            end
        end
        user
    end

    def add_game(user)
        puts "Would you like to add a game to your library?"
        puts "Yes or No:"
        yes_or_no = gets.chomp
        if yes_or_no == "Yes"
            puts "Would you like to see which games are available?"
            puts "Yes or no:"
            response = gets.chomp
            puts Game.all_name if response == "Yes"
            puts "Which game would you like to add?"
            new_game = gets.chomp
            puts "Would you like to see which consoles are available?"
            puts "Yes or no:"
            response2 = gets.chomp
            puts user.console_names if response2 == "Yes"
            puts "What console is your game on?"
            console_name = gets.chomp
            user.add_game_by_name_to_console_by_name(console_name, new_game)
            puts "#{new_game} has been successfully added to your #{console_name}"
        else
            puts "Thank you."
        end
    end

    def add_console(user)
        puts "Would you like to add a console to your library?"
        puts "Yes or No:"
        response = gets.chomp
        if response == "Yes"
            puts "Would you like to see which consoles are available?"
            puts "Yes or no:"
            response2 = gets.chomp
            puts (Console.console_all_names - user.console_names) if response2 == "Yes"
            puts "Which console would you like to add?"
            new_console = gets.chomp
            user.add_console_by_name(new_console)
            puts "#{new_console} has been added to your library."
        else
            puts "Thank you."
        end
    end

    def remove_game(user)
        puts "Would you like to remove a game from your library?"
        puts "Yes or No:"
        response = gets.chomp
        if response == "Yes"
            puts "Would you like to see a list of your games?"
            yes_or_no = gets.chomp
            puts user.game_names if yes_or_no == "Yes"
            puts "Which game would you like to remove?"
            game = gets.chomp
            puts "What console is this on? (If you'd like to view your consoles, type 'My Consoles'"
            consoles = gets.chomp
            puts user.console_names if consoles == "My Consoles"
            console = gets.chomp
            user.remove_game_by_name_from_console_by_name(console, game)
            puts "#{game} has been successfully removed from your #{console}."
        else
            puts "Thank you."
        end
    end

    def remove_console(user)
        puts "Would you like to remove a console from your library?"
        puts "Yes or no:"
        response = gets.chomp
        if response == "Yes"
            puts "Would you like to see a list of your consoles?"
            yes_or_no = gets.chomp
            puts user.console_names if yes_or_no == "Yes"
            puts "Which console would you like to remove?"
            console = gets.chomp
            user.remove_console_by_name(console)
            puts "#{console} has been successfully removed from your library."
        else
            puts "Thank you."
        end
    end

    def view_games(user)
        puts "Would you like to view your game library?"
        puts "Yes or No:"
        response = gets.chomp
        if response == "Yes"
            puts user.game_names
        else
            puts "Thank you."
        end
    end

    def view_common_games(user)
        puts "Would you like to view common games between you and another user?"
        puts "Yes or no:"
        yes_or_no = gets.chomp
        if yes_or_no == "Yes"
            puts "What is the other user's full name?"
            other_user = gets.chomp
            while !User.names.include?(other_user)
                puts "We could not find that user. Please re-enter."
                other_user = gets.chomp
            end
            puts user.common_games(User.find_by_name(other_user))
            puts "You and #{other_user} don't have any games in common." if user.common_games(User.find_by_name(other_user)) == []
        else
            puts "Thank you."
        end
    end

    def get_summary
        puts "Would you like to view a summary of a game?"
        puts "Yes or No:"
        yes_or_no = gets.chomp
        if yes_or_no == "Yes"
            puts "Which game would you like a summary of?"
            response = gets.chomp
            while !Game.all_name.include? response
                puts "We could not find that game. Please re-enter."
                response = gets.chomp
            end
            puts Game.find_by_name(response).summary
        else
            puts "Thank you."
        end
    end

    def get_rating(user)
        puts "Would you like to view the average user rating of a game?"
        puts "Yes or No:"
        yes_or_no = gets.chomp
        if yes_or_no == "Yes"
            puts "Would you like to view a list of your games?"
            input = gets.chomp
            puts user.game_names if input == "Yes"
            puts "Which game would you like to know the user rating of?"
            response = gets.chomp
            while !Game.all_name.include? response
                puts "We could not find that game. Please re-enter"
                response = gets.chomp
            end
            puts user.game_and_rating(response)
        else
            puts "Thank you."
        end
    end

    def get_ratings(user)
        puts "Would you like to view the average user ratings of your games?"
        puts "Yes or No:"
        response = gets.chomp
        if response == "Yes"
            puts user.games_and_ratings
        else
            puts "Thank you."
        end
    end

    def top_ten_games(user)
        puts "Would you like to view your top 10 rated games?"
        puts "Yes or No:"
        response = gets.chomp
        if response == "Yes"
            puts "Your top 10 rated games are:"
            puts "#{user.top_ten}"
        else
            puts "Thank you."
        end
    end

    def get_release_date(user)
        puts "Would you like to view the release date of a game?"
        puts "Yes or No:"
        yes_or_no = gets.chomp
        if yes_or_no == "Yes"
            puts "Would you like to view a list of your games?"
            input = gets.chomp
            puts user.game_names if input == "Yes"
            puts "Which game would you like to know the release date of?"
            game_name = gets.chomp
            while !user.game_names.include?(game_name)
                puts "We could not find that game. Please re-enter."
                game_name = gets.chomp
            end
            game = Game.find_by_name(game_name)
            if !game.first_release_date 
                puts "We don't have a release date on record for #{game_name}."
            else
                puts "The release date of #{game_name} was #{game.first_release_date.strftime('%Y-%m-%d')}."
            end
        else
            puts "Thank you."
        end
    end

    def get_release_dates(user)
        puts "Would you like to view the release dates of your games?"
        puts "Yes or No:"
        yes_or_no = gets.chomp
        if yes_or_no == "Yes"
            user.games.map do |game| 
                if !game.first_release_date 
                    puts "No release date on record for #{game.name}"
                else
                    puts "#{game.name} - #{game.first_release_date.strftime('%Y-%m-%d')}"
            end
        end
        else
            puts "Thank you."
        end
    end

    def how_many_games(user)
        puts "You have #{user.game_count} games in your library."
    end

    def help_menu
        puts "\nIf you want to view your library of games, type 'View Games'\n"\
            "To add a game to your library, type 'Add Game'\n"\
            "To add a console to your library, type 'Add Console' \n"\
            "To remove a game from your library, type 'Remove Game'\n"\
            "To remove a console from your library, type 'Remove Console'\n"\
            "To get a summary of a game, type 'Get Summary'\n"\
            "To view the average user rating of a game, type 'View Rating'\n"\
            "To view the average user rating of all your games as a list, type 'View Ratings'\n"\
            "To view the release date of a game, type 'View Release Date'\n"\
            "To view the release dates of all your games, type 'View Release Dates'\n"\
            "To view common games between another user and yourself, type 'Common Games'\n"\
            "To see the total number of games you have in your library, type 'Total Games'\n"\
            "To view the top 10 games in your library ordered by average user rating, type 'Top 10'\n"\
            "To quit this application, type 'Quit'"
    end

#Master method
    def what_would_you_like_to_do?(user)
        #add puts here to return "Happy Birthday #{user}!" if it's their birthday
        puts "\nHello, #{user.name}, what would you like to do?\n"\
        "(For a list of things you can ask me to do for you, type 'Help')"
        response = gets.chomp
        while response != "Quit"
        if response == "Help"
            help_menu
            response = gets.chomp
        elsif response == "View Games"
            view_games(user)
            puts "What would you like to do next?"
            response = gets.chomp
        elsif
            response == "Add Game"
            add_game(user)
            puts "What would you like to do next?"
            response = gets.chomp
        elsif
            response == 'Add Console'
            add_console(user)
            puts "What would you like to do next?"
            response = gets.chomp
        elsif
            response == "Remove Game"
            remove_game(user)
            puts "What would you like to do next?"
            response = gets.chomp
        elsif
            response == 'Remove Console'
            remove_console(user)
            puts "What would you like to do next?"
            response = gets.chomp
        elsif
            response == "Get Summary"
            get_summary
            puts "What would you like to do next?"
            response = gets.chomp
        elsif
            response == 'View Rating'
            get_rating(user)
            puts "What would you like to do next?"
            response = gets.chomp
        elsif
            response == "View Ratings"
            get_ratings(user)
            puts "What would you like to do next?"
            response = gets.chomp
        elsif
            response == 'View Release Date'
            get_release_date(user)
            puts "What would you like to do next?"
            response = gets.chomp
        elsif
            response == 'View Release Dates'
            get_release_dates(user)
            puts "What would you like to do next?"
            response = gets.chomp
        elsif
            response == "Common Games"
            view_common_games(user)
            puts "What would you like to do next?"
            response = gets.chomp
        elsif
            response == "Total Games"
            how_many_games(user)
            puts "What would you like to do next?"
            response = gets.chomp
        elsif
            response == 'Top 10'
            top_ten_games(user)
            puts "What would you like to do next?"
            response = gets.chomp
        end
        end
    end
end