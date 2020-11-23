ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])
require 'sinatra'
require 'sinatra/activerecord'




# set :database, 'sqlite3:db/taskmanager.sqlite'


ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

# require_relative "../app/controllers/application_controller.rb"
require_all 'app'