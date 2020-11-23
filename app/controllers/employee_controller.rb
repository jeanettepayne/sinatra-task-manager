class EmployeeController < ApplicationController

    get '/employees' do
        @employees = Employee.all
        
        erb :'employees/employees'
    end

    get '/employees/signup' do
        erb :'employees/create_employee'
    end

    post '/employees/signup' do
        # raise params
        # @new_employee = Employee.new(name: params["employee"]["name"], department: params["employee"]["department"], manager: params["employee"]["manager"], title: params["employee"]["title"], email: params["employee"]["email"], password: params["employee"]["password"])
        @new_employee = Employee.new(name: params["name"])
        binding.pry
        @new_employee.save
    
    end

    get '/employees/:slug' do
        @employee = Employee.find_by_slug(params[:slug])

        erb :'employees/show_employee'
    end


end