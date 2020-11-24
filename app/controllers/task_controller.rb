class TaskController < ApplicationController

    get '/tasks/new' do
        erb :'tasks_views/create_task'
    end

    post '/tasks' do
        
    end
    
    get '/tasks/:employee_slug' do
        @employee = Employee.find_by_slug(params[:employee_slug])

        erb :'tasks_views/show_tasks'
    end


end