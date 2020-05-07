require 'bundler'
require 'net/https'
require 'pry'
require 'json'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
# Turn off active record SQL printing to the terminal
ActiveRecord::Base.logger.level = 1
require_all 'lib'
require_all 'app/adapter'
