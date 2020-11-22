require 'bundler/setup'
Bundler.require

# ENV['SINATRA_ENV'] ||= "development"

configure :development do
    set :database, 'sqlite3:db/taskmanager.db'
end

# ActiveRecord::Base.establish_connection(
#   :adapter => "sqlite3",
#   :database => "db/task-manager#{ENV['SINATRA_ENV']}.sqlite"
# )

require_relative "../app/controllers/application_controller.rb"