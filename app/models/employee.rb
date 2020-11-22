class Employee < ActiveRecord::Base
    belongs_to :manager
    has_many :tasks
    has_secure_password
end