class ManagerController < ApplicationController


    get '/managers' do
        @managers = Manager.all

        erb :'managers/managers'
    end

end