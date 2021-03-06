class EmployeeController < ApplicationController

    get '/employees' do
        if employee_logged_in? || manager_logged_in?
            @employees = Employee.all
        
            erb :'employees/employees'
        else
            flash[:message] = "Log in to see employee list"
            redirect '/'
        end
    end

    get '/employees/signup' do
        erb :'employees/create_employee'
    end

    post '/employees/signup' do
        if Employee.find_by(email: params["employee"]["email"])
            flash[:message] = "Employee already exists! Please log in."
            redirect '/employees/login'
        else
            params["employee"]["manager"] = Manager.find_by_slug(params["employee"]["manager"])
            @employee = Employee.create(params["employee"])
            if @employee.save
                session[:employee_id] = @employee.id
                redirect "/employees/#{@employee.slug}"
            else
                flash[:message] = "Something went wrong! Please try again."
                redirect '/employees/signup'
            end
        end
    end

    get '/employees/login' do
        if !employee_logged_in?
            erb :'employees/login'
        elsif employee_logged_in?
            flash[:message] = "You're already logged in!"
            redirect '/employees'
        end
    end

    post '/employees/login' do
        @employee = Employee.find_by(email: params["employee"]["email"])
        if @employee && @employee.authenticate(params["employee"]["password"])
            session[:employee_id] = @employee.id
            redirect "/employees/#{@employee.slug}"
        else
            flash[:message] = "Something went wrong! Please try again"
            redirect '/employees/login'
        end
    end

    get '/employees/:slug' do
        if employee_logged_in? || manager_logged_in?
            @employee = Employee.find_by_slug(params[:slug])
            # @manager = @employee.manager

            erb :'employees/show_employee'
        else
            flash[:message] = "Please log in to see employee info"
            redirect '/'
        end
    end

    get '/employees/:slug/edit' do
        if employee_logged_in? || manager_logged_in?
            @employee = Employee.find_by_slug(params[:slug])
            if @employee && @employee == current_employee
                erb :'employees/edit_employee'
                # binding.pry
            elsif @employee && @employee.manager == current_manager
                erb :'employees/edit_employee'
            else
                flash[:message] = "Looks like you don't have permission to edit this employee!"
                redirect "/employees/#{@employee.slug}"
            end
        else
            flash[:message] = "Please log in to edit employee info"
            redirect '/'
        end
    end

    patch '/employees/:slug' do
        @employee = Employee.find_by_slug(params[:slug])
        params["employee"]["manager"] = Manager.find_by_slug(params["employee"]["manager"])
        @employee.update(params["employee"])

        redirect "/employees/#{@employee.slug}"
    end

    get '/employees/:slug/delete' do
        if employee_logged_in? || manager_logged_in?
            @employee = Employee.find_by_slug(params[:slug])
            if @employee && @employee == current_employee
                @employee.delete
                flash[:message] = "Employee successfully deleted"
                redirect '/'
            elsif @employee  && @employee.manager == current_manager
                @employee.delete
                flash[:message] = "Employee successfully deleted"
                redirect '/'
            end
        end
        flash[:message] = "Looks like you don't have permission to delete this employee! Nice try!"
        redirect "/employees/#{@employee.slug}"
    end

end