class GamesApi
    @@user_key = 'API KEY HERE'

    def self.get_games(count)
        http = Net::HTTP.new('api-v3.igdb.com',443)
        http.use_ssl = true
        request = Net::HTTP::Post.new(URI('https://api-v3.igdb.com/games'), {'user-key' => @@user_key})
        request.body = "fields name, first_release_date, rating, summary; limit #{count};"
        response_string = http.request(request).body
        response_array = JSON.parse(response_string)
    end
    
    def self.get_consoles(count)
        http = Net::HTTP.new('api-v3.igdb.com',443)
        http.use_ssl = true
        request = Net::HTTP::Post.new(URI('https://api-v3.igdb.com/platforms'), {'user-key' => @@user_key})
        request.body = "fields name; limit #{count};"
        response_string = http.request(request).body
        response_array = JSON.parse(response_string)
    end
end