class EmployeeController < ApplicationController

    get '/employees' do
        @employees = Employee.all
        
        erb :'employees/employees'
    end

    get '/employees/signup' do
        erb :'employees/create_employee'
    end

    post '/employees/signup' do
        # NEED TO ADD MANAGER BACK IN TO EMPLOYEE BELOW
        @new_employee = Employee.create(name: params["employee"]["name"], department: params["employee"]["department"], title: params["employee"]["title"], email: params["employee"]["email"], password: params["employee"]["password"])
        # @new_employee = Employee.new(params["employee"])
        # binding.pry
        @new_employee.save
    
    end

    get '/employees/logout' do
        if logged_in?
            session.destroy
            redirect '/employees/login'
        # else
        #     redirect '/'
        end
    end

    get '/employees/:slug' do
        @employee = Employee.find_by_slug(params[:slug])

        erb :'employees/show_employee'
    end

    helpers do

        def logged_in?
            !!current_user
        end

        def current_user
            @current_user ||= Employee.find_by(id: session[:employee_id]) if session[:employee_id]
        end

    end


end