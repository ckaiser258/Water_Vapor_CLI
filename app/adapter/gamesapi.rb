require 'net/https'

class GamesApi
    def self.get_platform
        http = Net::HTTP.new('api-v3.igdb.com',443)
        http.use_ssl = true
        request = Net::HTTP::Post.new(URI('https://api-v3.igdb.com/platforms'), {'user-key' => ''})
        request.body = 'fields name;'
        puts http.request(request).body
        # books = json_response["items"].map do |item| 
        #   {description: item["volumeInfo"]["description"],
        #   title: item["volumeInfo"]["title"]}
        # end
        # binding.pry
      end

    def self.get_genre
        http = Net::HTTP.new('api-v3.igdb.com',443)
        http.use_ssl = true
        request = Net::HTTP::Post.new(URI('https://api-v3.igdb.com/genres'), {'user-key' => ''})
        request.body = 'fields name;'
        puts http.request(request).body
    end

    def self.get_games
        http = Net::HTTP.new('api-v3.igdb.com',443)
        http.use_ssl = true
        request = Net::HTTP::Post.new(URI('https://api-v3.igdb.com/games'), {'user-key' => ''})
        request.body = 'fields name; where name = "Halo: Combat Evolved";'
        puts http.request(request).body
    end
end

GamesApi.get_games