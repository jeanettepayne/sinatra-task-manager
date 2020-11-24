class TaskController < ApplicationController

    # get '/tasks/:employee_slug/new' do
    #     erb :'tasks_views/create_task'
    # end

    # post '/tasks' do

    # end

    
    get '/tasks/:employee_slug' do
        @employee = Employee.find_by_slug(params[:employee_slug])

        erb :'tasks_views/show_tasks'
    end

    get '/tasks/:employee_slug/new' do
        @employee = Employee.find_by_slug(params[:employee_slug])

        erb :'tasks_views/create_task'
    end

    post '/tasks/:employee_slug' do
        @employee = Employee.find_by_slug(params[:employee_slug])
        @task = Task.new(params["task"])
        @task.employee_id = @employee.id
        @task.save
    end


end