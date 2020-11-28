class TaskController < ApplicationController

    
    
    get '/tasks/:employee_slug' do
        if employee_logged_in? || manager_logged_in?
            @employee = Employee.find_by_slug(params[:employee_slug])
            @manager = @employee.manager

            erb :'tasks_views/show_tasks'
        else
            flash[:message] = "Please log in to view tasks"
            redirect '/'
        end
    end

    get '/tasks/:employee_slug/new' do
        if employee_logged_in? || manager_logged_in?
            @employee = Employee.find_by_slug(params[:employee_slug])
            if @employee && @employee == current_employee
                erb :'tasks_views/create_task'
            elsif @employee && @employee.manager == current_manager
                erb :'tasks_views/create_task'
            else
                redirect "/tasks/#{@employee.slug}/new"
            end
        else
            flash[:message] = "Please log in to add tasks"
            redirect '/'
        end
    end

    get '/tasks/:employee_slug/:id' do
        if employee_logged_in? || manager_logged_in?
            @employee = Employee.find_by_slug(params[:employee_slug])
            @task = Task.find_by_id(params[:id])

            erb :'tasks_views/show_task'
        else
            flash[:message] = "Please log in to view tasks"
            redirect '/'
        end
    end

    get '/tasks/:employee_slug/:id/edit' do
        if employee_logged_in? || manager_logged_in?
            @employee = Employee.find_by_slug(params[:employee_slug])
            @task = Task.find_by_id(params[:id])
            if @employee && @employee == current_employee
                erb :'tasks_views/edit_task'
            elsif @employee && @employee.manager == current_manager
                erb :'tasks_views/edit_task'
            else
                redirect "/tasks/#{@employee.slug}/#{@task.id}"
            end
        else
            flash[:message] = "Please log in to edit tasks"
            redirect '/'
        end
    end

    patch '/tasks/:employee_slug/:id' do
        @employee = Employee.find_by_slug(params[:employee_slug])
        @task = Task.find_by_id(params[:id])

        @task.update(params["task"])

        redirect "/tasks/#{@employee.slug}"
    end

    get '/tasks/:employee_slug/:id/delete' do
        if employee_logged_in? || manager_logged_in?
            task = Task.find_by_id(params[:id])
            @employee = task.employee
            if @employee && @employee == current_employee
                task.delete
            elsif @employee && @employee.manager == current_manager
                task.delete
            else
                redirect "/tasks/#{@employee.slug}/#{task.id}"
            end
        else
            flash[:message] = "Please log in to delete tasks"
            redirect '/'
        end
    end

    post '/tasks/:employee_slug' do
        @employee = Employee.find_by_slug(params[:employee_slug])
        @task = Task.new(params["task"])
        @task.employee_id = @employee.id
        @task.save
        
        redirect "/tasks/#{@employee.slug}"
    end



end