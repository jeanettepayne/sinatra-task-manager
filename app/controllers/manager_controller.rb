class ManagerController < ApplicationController


    get '/managers' do
        if manager_logged_in? || employee_logged_in?
            @managers = Manager.all

            erb :'managers/managers'
        else
            redirect '/'
        end
    end

    get '/managers/signup' do
        erb :'managers/create_manager'
    end

    post '/managers/signup' do
        if Manager.find_by(email: params["manager"]["email"])
            redirect '/managers/signup'
        else
            @manager = Manager.create(params["manager"])
            if @manager.save
                session[:manager_id] = @manager.id
                redirect "/managers/#{@manager.slug}"
            else
                redirect '/managers/signup'
            end
        end
    end

    get '/managers/login' do
        if !manager_logged_in?
            erb :'managers/login'
        elsif manager_logged_in?
            redirect '/managers'
        end
    end

    post '/managers/login' do
        @manager = Manager.find_by(email: params["manager"]["email"])
        if @manager && @manager.authenticate(params["manager"]["password"])
            session[:manager_id] = @manager.id
            redirect '/managers'
        else
            redirect '/managers/login'
        end
    end

    get '/managers/:slug' do
        if manager_logged_in? || employee_logged_in?
            @manager = Manager.find_by_slug(params[:slug])
        
            erb :'managers/show_manager'
        else
            redirect '/'
        end
    end

    get '/managers/:slug/edit' do
        if manager_logged_in?
            @manager = Manager.find_by_slug(params[:slug])
            if @manager && @manager == current_manager
                erb :'managers/edit_manager'
            else
                redirect "/managers/#{@manager.slug}"
            end
        else
            redirect '/'
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
            end
        end
        redirect '/managers'
    end

end