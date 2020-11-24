class TaskController < ApplicationController

    get '/tasks/:employee_slug' do
        @employee = Employee.find_by_slug(params[:employee_slug])

        erb :'tasks_views/show_tasks'
    end

end