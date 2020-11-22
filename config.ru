require 'sinatra'
require './config/environment'
# require_relative './app/controllers'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride

run ApplicationController
use EmployeeController
use ManagerController
use TaskController