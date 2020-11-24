require './config/environment'

class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        # set :database, "sqlite3:task-manager.sqlite3"
        enable :sessions
        set :session_secret, "password_security"
    end

    get '/' do
        erb :'index'
    end

    get '/logout' do
        if employee_logged_in? || manager_logged_in?
            session.destroy
        end
        redirect '/'
    end

    helpers do

        def employee_logged_in?
            !!current_employee
        end

        def current_employee
            @current_employee ||= Employee.find_by(id: session[:employee_id]) if session[:employee_id]
        end

        def manager_logged_in?
            !!current_manager
        end

        def current_manager
            @current_manager ||= Manager.find_by(id: session[:manager_id]) if session[:manager_id]
        end

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