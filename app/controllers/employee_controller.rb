class EmployeeController < ApplicationController

    get '/employees' do
        @employees = Employee.all

        erb :'employees/employees'
    end

    get '/employees/signup' do
        erb :'employees/create_employee'
    end

    post '/employees' do

    end

    get '/employees/:slug' do
        @employee = Employee.find_by_slug(params[:slug])

        erb :'employees/show_employee'
    end


end