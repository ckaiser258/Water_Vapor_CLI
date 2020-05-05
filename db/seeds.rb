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