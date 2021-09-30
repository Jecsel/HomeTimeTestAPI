class Guest < ApplicationRecord
    has_many :reservations
    has_many :phones

    def self.checkEmailIfExists email
        return self.find_by_email(email).present?
    end

    def self.createNew param
        guest = self.create param
        
        return guest
    end
end
