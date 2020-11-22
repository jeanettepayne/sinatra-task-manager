class Manager < ActiveRecord::Base
    has_many :employees
    has_secure_password
end