# Manually assign seed counts to be used when creating/pulling seeds
user_seed_count = 20
console_seed_count = 30
game_seed_count = 50
console_game_seed_count = 75

# Clear all old data
User.destroy_all
Console.destroy_all
Game.destroy_all
ConsoleGame.destroy_all

# User seeds via Faker gem
user_seed_count.times do
    name = Faker::Name.name
    birthday = Faker::Date.birthday(min_age: 1, max_age:100)
    User.create(name: name, birthday: birthday)
end

# Console seeds via Faker gem, assign Consoles to random Users
console_seed_count.times do
    name = Faker::Games::Pokemon.name
    user = User.all[rand(user_seed_count)]
    user.create_console(name)
end

# Game seeds from IGDB API
def get_games(count)
    http = Net::HTTP.new('api-v3.igdb.com',443)
    http.use_ssl = true
    request = Net::HTTP::Post.new(URI('https://api-v3.igdb.com/games'), {'user-key' => '604d3e58cf35c387d2cc94b3e51ecc35'})
    request.body = "fields name, first_release_date, rating, summary; limit #{count};"
    response_string = http.request(request).body
    response_array = JSON.parse(response_string)
    # Parse data and create Game classes
    response_array.each do |game|
        name = game["name"]
        first_release_date = DateTime.strptime(game["first_release_date"].to_s,"%s") if game["first_release_date"]
        rating = game["rating"]
        summary = game["summary"]
        Game.create(name: name, first_release_date: first_release_date, rating: rating, summary: summary)
    end
end
get_games(game_seed_count)

# GameConsole seeds
console_game_seed_count.times do
    game = Game.all[rand(game_seed_count)]
    console = Console.all[rand(console_seed_count)]
    user = console.user
    user.add_game_to_console(console, game)
end
