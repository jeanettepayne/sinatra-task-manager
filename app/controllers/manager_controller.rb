class ManagerController < ApplicationController


    get '/managers' do
        @managers = Manager.all

        erb :'managers/managers'
    end

    get '/managers/signup' do
        erb :'managers/create_manager'
    end

    post '/managers/signup' do
        @manager = Manager.new(params["manager"])
        @manager.save
        # binding.pry
    end

    get '/managers/:slug' do
        @manager = Manager.find_by_slug(params[:slug])
        # binding.pry
        erb :'managers/show_manager'
    end

end