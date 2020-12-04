class Task < ActiveRecord::Base
    belongs_to :employee

    # def employee_slug
    #     self.employee.name.gsub(" ", "-").downcase
    # end

    # def self.find_by_slug(employee_slug)
    #     Employee.all.find{|name| name.slug == slug}
    # end

end