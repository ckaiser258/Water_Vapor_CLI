# Clear all old data
User.destroy_all
Console.destroy_all
Game.destroy_all
ConsoleGame.destroy_all

# Manually assign seed counts to be used when creating/pulling seeds
user_seed_count = 25
console_seed_count = 35
game_seed_count = 45
console_game_seed_count =35

# User seeds via Faker gem
user_seed_count.times do
    name = Faker::Name.name
    birthday = Faker::Date.birthday(min_age: 1, max_age:100)
    User.create(name: name, birthday: birthday)
end

# Game seeds from IGDB API
GamesApi.get_games(game_seed_count).each do |game|
    name = game["name"]
    first_release_date = game["first_release_date"]
    rating = game["rating"]
    summary = game["summary"]
    Game.create(name: name, first_release_date: first_release_date, rating: rating, summary: summary)
end

# Add consoles to db and assign user id's
GamesApi.get_consoles(console_seed_count).each do |console|
    name = console["name"]
    user = User.all[rand(user_seed_count)]
    user.create_console(name)
end

# GameConsole seeds
console_game_seed_count.times do
    game = Game.all[rand(game_seed_count)]
    console = Console.all[rand(console_seed_count)]
    user = console.user
    user.add_game_to_console(console, game)
end


