class EmployeeController < ApplicationController

    get '/employees' do
        @employees = Employee.all

        erb :'employees/employees'
    end

end