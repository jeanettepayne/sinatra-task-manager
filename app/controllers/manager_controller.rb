class ManagerController < ApplicationController


    get '/managers' do
        @managers = Manager.all

        erb :'managers/managers'
    end

    get '/managers/:slug' do
        @manager = Manager.find_by_slug(params[:slug])

        erb :'managers/show_manager'
    end

end