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
        params["employee"]["manager"] = Manager.find_by_slug(params["employee"]["manager"])
        # binding.pry
        # @manager = Manager.find_by_slug(params["employee"]["manager"])
        # NEED TO ADD MANAGER BACK IN TO EMPLOYEE BELOW
        # @new_employee = Employee.create(name: params["employee"]["name"], department: params["employee"]["department"], title: params["employee"]["title"], email: params["employee"]["email"], password: params["employee"]["password"])
        @employee = Employee.create(params["employee"])
        if @employee.save
            session[:employee_id] = @employee.id
            redirect "/employees/#{@employee.slug}"
        else
            redirect '/'
        end
    end

    get '/employees/login' do
        erb :'employees/login'
    end

    post '/employees/login' do
        @employee = Employee.find_by(email: params["employee"]["email"])
        if @employee && @employee.authenticate(params["employee"]["password"])
            session[:employee_id] = @employee.id
            redirect '/employees'
        else
            redirect '/employees/login'
        end
    end

    # get '/logout' do
    #     if logged_in?
    #         session.destroy
    #     end
    #     redirect '/'
    # end

    get '/employees/:slug' do
        if employee_logged_in? || manager_logged_in?
            @employee = Employee.find_by_slug(params[:slug])

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
        params["employee"]["manager"] = Manager.find_by_slug(params["employee"]["manager"])
        @employee.update(params["employee"])

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