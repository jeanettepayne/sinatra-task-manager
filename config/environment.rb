require 'bundler/setup'
Bundler.require
require 'sinatra'
require 'sinatra/activerecord'

ENV['SINATRA_ENV'] ||= "development"


set :database, 'sqlite3:db/taskmanager.sqlite'


# ActiveRecord::Base.establish_connection(
#   :adapter => "sqlite3",
#   :database => "db/task-manager#{ENV['SINATRA_ENV']}.sqlite"
# )

require_relative "../app/controllers/application_controller.rb"