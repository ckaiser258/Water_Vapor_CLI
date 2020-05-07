require_relative '../config/environment'
a = Artii::Base.new :font => 'slant'

puts a.asciify('Water Vapor')

cli = CommandLineInterface.new

user = cli.login

cli.what_would_you_like_to_do?(user)