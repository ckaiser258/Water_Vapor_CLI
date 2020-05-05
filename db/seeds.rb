
# Clear all old data
User.destroy_all
Console.destroy_all
Game.destroy_all
ConsoleGame.destroy_all


# Manual Seeds
mat = User.create(name: "Mat", birthday: "1987-12-03")
brian = User.create(name: "Brian", birthday: "1990-06-03")
mat_xbox = Console.create(name: "Xbox One")
mat.consoles.push(mat_xbox)
brians_playstation = brian.add_console_by_name("Playstation")
halo = Game.create(name: "Halo")
halo2 = Game.create(name: "Halo 2")
halo100 = Game.create(name: "Halo 100")
mat.add_game_to_console(mat_xbox, halo)
mat.add_game_to_console(mat_xbox, halo2)
mat.add_game_by_name_to_console(mat_xbox, "Halo 100")


GamesApi.get_games

# name
# first_release_date
# rating
# summary

def get_20_games
    http = Net::HTTP.new('api-v3.igdb.com',443)
    http.use_ssl = true
    request = Net::HTTP::Post.new(URI('https://api-v3.igdb.com/games'), {'user-key' => '604d3e58cf35c387d2cc94b3e51ecc35'})
    request.body = 'fields name, first_release_date, rating, summary; limit 20;'
    puts http.request(request).body
end
