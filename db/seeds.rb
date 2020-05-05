# Clear all old data
User.destroy_all
Console.destroy_all
Game.destroy_all
ConsoleGame.destroy_all


# Manual Seeds
# mat = User.create(name: "Mat", birthday: "1987-12-03")
# brian = User.create(name: "Brian", birthday: "1990-06-03")
# mat_xbox = Console.create(name: "Xbox One")
# mat.consoles.push(mat_xbox)
# brians_playstation = brian.add_console_by_name("Playstation")
# halo = Game.create(name: "Halo")
# halo2 = Game.create(name: "Halo 2")
# halo100 = Game.create(name: "Halo 100")
# mat.add_game_to_console(mat_xbox, halo)
# mat.add_game_to_console(mat_xbox, halo2)
# mat.add_game_by_name_to_console(mat_xbox, "Halo 100")

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

# Console seeds via Faker gem, assign Consoles to random Users
console_seed_count.times do
    name = Faker::Games::Pokemon.name
    user = User.all[rand(user_seed_count)]
    user.create_console(name)
end

# Game seeds from IGDB API
game_seed_count.times do
    #API stuff here, faker is just a placeholder
    name = Faker::Games::SuperSmashBros.fighter
    Game.create(name: name)
end

# GameConsole seeds
console_game_seed_count.times do
    game = Game.all[rand(game_seed_count)]
    console = Console.all[rand(console_seed_count)]
    user = console.user
    user.add_game_to_console(console, game)
end
