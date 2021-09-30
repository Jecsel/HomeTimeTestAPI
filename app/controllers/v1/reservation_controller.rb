class V1::ReservationController < ApplicationController
    skip_before_action :verify_authenticity_token, only:[:create]



    def create
        begin
            payload_of = whichPayload(params)                                                                               # check if whose payload format this is
            if !payload_of.nil?
                guest_data =  getGuestDatas(params, payload_of)                                                                 # reconstruct the data for guest creation of new record or verifying
                reservation_data = getReservationDatas(params, payload_of)                                                      # reconstruct the data for reservation creation of new record or verifying 
                guest_phone_numbers = getPhoneDatas(params, payload_of)
                email_exist = Guest.checkEmailIfExists(guest_data["email"])     

                ! email_exist ? guest = Guest.create(guest_data) : guest = Guest.find_by_email(guest_data["email"])             # create new guest if email not found else find it
                reservation = guest.reservations.create(reservation_data)                                                       #create new reservation

                guest_phone_numbers.each do |number|
                    guest.phones.create(number)
                end

                if reservation.validate!
                    json_response(reservation)
                else
                    error_500('Failed to save reservation.')
                end 
            end
            
        rescue => exception
            error_500(exception)
        end
    end

end
