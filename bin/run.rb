require_relative '../config/environment'

artii 'Water Vapor' --font slant

cli = CommandLineInterface.new

user = cli.login

cli.what_would_you_like_to_do?(user)