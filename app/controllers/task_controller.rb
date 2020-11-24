class TaskController < ApplicationController

    # get '/tasks/:employee_slug/new' do
    #     erb :'tasks_views/create_task'
    # end

    # post '/tasks' do

    # end

    
    
    get '/tasks/:employee_slug' do
        @employee = Employee.find_by_slug(params[:employee_slug])
        @manager = @employee.manager

        erb :'tasks_views/show_tasks'
    end

    get '/tasks/:employee_slug/new' do
        @employee = Employee.find_by_slug(params[:employee_slug])

        erb :'tasks_views/create_task'
    end

    get '/tasks/:employee_slug/:id' do
        @employee = Employee.find_by_slug(params[:employee_slug])
        @task = Task.find_by_id(params[:id])

        erb :'tasks_views/show_task'
    end

    get '/tasks/:employee_slug/:id/edit' do
        @employee = Employee.find_by_slug(params[:employee_slug])
        @task = Task.find_by_id(params[:id])

        erb :'tasks_views/edit_task'
    end

    patch '/tasks/:employee_slug/:id' do
        @employee = Employee.find_by_slug(params[:employee_slug])
        @task = Task.find_by_id(params[:id])

        @task.update(params["task"])

        redirect "/tasks/#{@employee.slug}"
    end

    get '/tasks/:employee_slug/:id/delete' do
        task = Task.find_by_id(params[:id])
        # binding.pry
        @employee = task.employee
        task.delete

        redirect "/tasks/#{@employee.slug}"
    end

    post '/tasks/:employee_slug' do
        @employee = Employee.find_by_slug(params[:employee_slug])
        @task = Task.new(params["task"])
        @task.employee_id = @employee.id
        @task.save
        
        redirect "/tasks/#{@employee.slug}"
    end

    # helpers do

    #     def employee_logged_in?
    #         !!current_employee
    #     end

    #     def current_employee
    #         @current_employee ||= Employee.find_by(id: session[:employee_id]) if session[:employee_id]
    #     end

    #     def manager_logged_in?
    #         !!current_manager
    #     end

    #     def current_manager
    #         @current_manager ||= Manager.find_by(id: session[:manager_id]) if session[:manager_id]
    #     end

    # end


end