class EmployeeController < ApplicationController

    get '/employees' do
        @employees = Employee.all

        erb :'employees/employees'
    end

    get '/employees/:id' do
        @employee = Employee.find_by(id: params[:id])

        erb :'employees/show_employee'
    end

end