class Employee < ActiveRecord::Base
    belongs_to :manager
    has_many :tasks
    has_secure_password

    def slug
        self.name.gsub(" ", "-").downcase
    end

    def self.find_by_slug(slug)
        self.all.find{|name| name.slug == slug}
    end
end