class TaskController < ApplicationController

    # get '/tasks/:employee_slug/new' do
    #     erb :'tasks_views/create_task'
    # end

    # post '/tasks' do

    # end

    

    delete '/tasks/:id/delete' do
        task = Task.find_by_id(params[:id])
        binding.pry
        @employee = task.employee
        task.delete

        redirect "/tasks/#{@employee.slug}"
    end
    
    
    get '/tasks/:employee_slug' do
        @employee = Employee.find_by_slug(params[:employee_slug])

        erb :'tasks_views/show_tasks'
    end

    get '/tasks/:employee_slug/new' do
        @employee = Employee.find_by_slug(params[:employee_slug])

        erb :'tasks_views/create_task'
    end

    get '/tasks/:employee_slug/:id' do
        erb :'tasks_views/show_task'
    end

    post '/tasks/:employee_slug' do
        @employee = Employee.find_by_slug(params[:employee_slug])
        @task = Task.new(params["task"])
        @task.employee_id = @employee.id
        @task.save
        
        redirect "/tasks/#{@employee.slug}"
    end


end