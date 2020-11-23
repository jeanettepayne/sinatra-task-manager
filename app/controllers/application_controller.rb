require './config/environment'

class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        # set :database, "sqlite3:task-manager.sqlite3"
        enable :sessions
        set :session_secret, "password_security"
    end

end