require './config/environment'

class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        # set :database, "sqlite3:task-manager.sqlite3"
        enable :sessions
        set :session_secret, "password_security"
    end

    # helpers do

    #     def logged_in?
    #         !!current_user
    #     end

    #     def current_user
    #         @current_user ||= user.find_by(id: session[:user_id]) if session[:user_id]
    #     end

    # end

end