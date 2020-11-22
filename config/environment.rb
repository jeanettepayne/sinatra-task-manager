require 'bundler/setup'
Bundler.require

ENV['SINATRA_ENV'] ||= "development"

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/task-manager#{ENV['SINATRA_ENV']}.sqlite"
)

require_relative "../app/controllers/application_controller.rb"