# Clear all old data
User.destroy_all
Console.destroy_all
Game.destroy_all
ConsoleGame.destroy_all


def get_games(count)
    http = Net::HTTP.new('api-v3.igdb.com',443)
    http.use_ssl = true
    request = Net::HTTP::Post.new(URI('https://api-v3.igdb.com/games'), {'user-key' => '604d3e58cf35c387d2cc94b3e51ecc35'})
    request.body = "fields name, first_release_date, rating, summary; limit #{count};"
    response_string = http.request(request).body
    response_array = JSON.parse(response_string)
    response_array.each do |game|
        # binding.pry
        name = game["name"]
        first_release_date = game["first_release_date"] if game["first_release_date"]
        rating = game["rating"] if game["rating"]
        summary = game["summary"] if game["summary"]
        Game.create(name: name, first_release_date: first_release_date, rating: rating, summary: summary)
    end
end

get_games(20)