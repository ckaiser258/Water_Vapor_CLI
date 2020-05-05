require 'net/https'
require 'pry'

class GamesApi
    def self.get_platforms
        http = Net::HTTP.new('api-v3.igdb.com',443)
        http.use_ssl = true
        request = Net::HTTP::Post.new(URI('https://api-v3.igdb.com/platforms'), {'user-key' => '604d3e58cf35c387d2cc94b3e51ecc35'})
        request.body = 'fields name;'
        puts http.request(request).body
        # books = json_response["items"].map do |item| 
        #   {description: item["volumeInfo"]["description"],
        #   title: item["volumeInfo"]["title"]}
        # end
        # binding.pry
      end

    def self.get_genres
        http = Net::HTTP.new('api-v3.igdb.com',443)
        http.use_ssl = true
        request = Net::HTTP::Post.new(URI('https://api-v3.igdb.com/genres'), {'user-key' => '604d3e58cf35c387d2cc94b3e51ecc35'})
        request.body = 'fields multiplayer, name;'
        puts http.request(request).body
    end

    def self.get_games
        http = Net::HTTP.new('api-v3.igdb.com',443)
        http.use_ssl = true
        request = Net::HTTP::Post.new(URI('https://api-v3.igdb.com/games'), {'user-key' => '604d3e58cf35c387d2cc94b3e51ecc35'})
        request.body = 'fields name, first_release_date, rating, summary;'
        puts http.request(request).body
    end

    def self.get_20_games
        http = Net::HTTP.new('api-v3.igdb.com',443)
        http.use_ssl = true
        request = Net::HTTP::Post.new(URI('https://api-v3.igdb.com/games'), {'user-key' => '604d3e58cf35c387d2cc94b3e51ecc35'})
        request.body = 'fields name, first_release_date, rating, summary; limit 20;'
        puts http.request(request).body
    end
end

GamesApi.get_games