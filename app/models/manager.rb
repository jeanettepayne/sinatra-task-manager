class Manager < ActiveRecord::Base
    has_many :employees
    has_secure_password

    def slug
        self.name.gsub(" ", "-").downcase
    end

    def self.find_by_slug(slug)
        self.all.find{|name| name.slug == slug}
    end
    
end