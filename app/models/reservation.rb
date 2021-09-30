class Reservation < ApplicationRecord
    has_one :guest
end
