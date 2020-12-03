class ManagerController < ApplicationController


    get '/managers' do
        if manager_logged_in? || employee_logged_in?
            @managers = Manager.all

            erb :'managers/managers'
        else
            flash[:message] = "Log in to see manager list"
            redirect '/'
        end
    end

    get '/managers/signup' do
        erb :'managers/create_manager'
    end

    post '/managers/signup' do
        if Manager.find_by(email: params["manager"]["email"])
            flash[:message] = "Manager already exists! Please log in."
            redirect '/managers/login'
        else
            @manager = Manager.create(params["manager"])
            if @manager.save
                session[:manager_id] = @manager.id
                redirect "/managers/#{@manager.slug}"
            else
                flash[:message] = "Something went wrong! Please try again."
                redirect '/managers/signup'
            end
        end
    end

    get '/managers/login' do
        if !manager_logged_in?
            erb :'managers/login'
        elsif manager_logged_in?
            flash[:message] = "You're already logged in!"
            redirect '/managers'
        end
    end

    post '/managers/login' do
        @manager = Manager.find_by(email: params["manager"]["email"])
        if @manager && @manager.authenticate(params["manager"]["password"])
            session[:manager_id] = @manager.id
            redirect '/managers'
        else
            flash[:message] = "Something went wrong! Please try again"
            redirect '/managers/login'
        end
    end

    get '/managers/:slug' do
        if manager_logged_in? || employee_logged_in?
            @manager = Manager.find_by_slug(params[:slug])
        
            erb :'managers/show_manager'
        else
            flash[:message] = "Please log in to see manager info"
            redirect '/'
        end
    end

    get '/managers/:slug/edit' do
        if manager_logged_in?
            @manager = Manager.find_by_slug(params[:slug])
            if @manager && @manager == current_manager
                erb :'managers/edit_manager'
            else
                flash[:message] = "Looks like you don't have permission to edit this manager!"
                redirect "/managers/#{@manager.slug}"
            end
        else
            @manager = Manager.find_by_slug(params[:slug])
            flash[:message] = "Looks like you don't have permission to edit this manager!"
            redirect "/managers/#{@manager.slug}"
        end
    end

    patch '/managers/:slug' do
        @manager = Manager.find_by_slug(params[:slug])

        @manager.update(params["manager"])

        redirect "/managers/#{@manager.slug}"
    end

    get '/managers/:slug/delete' do
        if manager_logged_in?
            @manager = Manager.find_by_slug(params[:slug])
            if @manager && @manager == current_manager
                @manager.delete
                flash[:message] = "Manager successfully deleted"
                redirect '/'
            end
        end
        flash[:message] = "Looks like you don't have permission to delete this manager!"
        redirect "/managers/#{@manager.slug}"
    end

end