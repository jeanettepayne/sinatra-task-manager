class EmployeeController < ApplicationController

    get '/employees' do
        if employee_logged_in? || manager_logged_in?
            @employees = Employee.all
        
            erb :'employees/employees'
        else
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
            redirect '/employees'
        end
    end

    post '/employees/login' do
        @employee = Employee.find_by(email: params["employee"]["email"])
        if @employee && @employee.authenticate(params["employee"]["password"])
            session[:employee_id] = @employee.id
            redirect "/employees/#{@employee.slug}"
        else
            redirect '/employees/login'
        end
    end

    get '/employees/:slug' do
        if employee_logged_in? || manager_logged_in?
            @employee = Employee.find_by_slug(params[:slug])
            # @manager = @employee.manager

            erb :'employees/show_employee'
        else
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
                redirect "/employees/#{@employee.slug}"
            end
        else
            redirect '/'
        end
    end

    patch '/employees/:slug' do
        @employee = Employee.find_by_slug(params[:slug])
        # binding.pry
        params["employee"]["manager"] = Manager.find_by_slug(params["employee"]["manager"])
        @employee.update(params["employee"])
        @employee.save

        redirect "/employees/#{@employee.slug}"
    end

    get '/employees/:slug/delete' do
        if employee_logged_in? || manager_logged_in?
            @employee = Employee.find_by_slug(params[:slug])
            if @employee && @employee == current_user
                @employee.delete
            elsif @employee  && @employee.manager == current_manager
                @employee.delete
            end
        end
        redirect '/employees'
    end

end