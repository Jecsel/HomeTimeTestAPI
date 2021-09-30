class ApplicationController < ActionController::Base

    def ping
        render json: { message: 'HomeTime API is UP!'}
    end

    def getGuestDatas( data, company )
        guest_reconstructed_data = {}
        if company == 'airbnb'
            guest_reconstructed_data["first_name"] = data[:guest][:first_name]
            guest_reconstructed_data["last_name"] = data[:guest][:last_name]
            guest_reconstructed_data["email"] = data[:guest][:email]
        end

        if company == 'booking'
            guest_reconstructed_data["first_name"] = data[:reservation][:guest_first_name]
            guest_reconstructed_data["last_name"] = data[:reservation][:guest_last_name]
            guest_reconstructed_data["email"] = data[:reservation][:guest_email]
        end
        return guest_reconstructed_data
    end

    def getReservationDatas( data, company )
        reservation_reconstructed_data = {}
        if company == 'airbnb'
            reservation_reconstructed_data["start_date"] = data[:start_date]
            reservation_reconstructed_data["end_date"] = data[:end_date]
            reservation_reconstructed_data["nights"] = data[:nights]
            reservation_reconstructed_data["guests"] = data[:guests]
            reservation_reconstructed_data["adults"] = data[:adults]
            reservation_reconstructed_data["children"] = data[:children]
            reservation_reconstructed_data["infants"] = data[:infants]
            reservation_reconstructed_data["status"] = data[:status]
            reservation_reconstructed_data["currency"] = data[:currency]
            reservation_reconstructed_data["payout_price"] = data[:payout_price]
            reservation_reconstructed_data["security_price"] = data[:security_price]
            reservation_reconstructed_data["total_price"] = data[:total_price]
        end

        if company == 'booking'
            reserve = data[:reservation]
            reservation_reconstructed_data["start_date"] = reserve[:start_date]
            reservation_reconstructed_data["end_date"] = reserve[:end_date]
            reservation_reconstructed_data["nights"] =
            reservation_reconstructed_data["guests"] = reserve[:guest_details][:localized_description]
            reservation_reconstructed_data["adults"] = reserve[:guest_details][:number_of_adults]
            reservation_reconstructed_data["children"] = reserve[:guest_details][:number_of_children]
            reservation_reconstructed_data["infants"] = reserve[:guest_details][:number_of_infants]
            reservation_reconstructed_data["status"] = reserve[:status_type]
            reservation_reconstructed_data["currency"] = reserve[:host_currency]
            reservation_reconstructed_data["payout_price"] = reserve[:expected_payout_amount]
            reservation_reconstructed_data["security_price"] = reserve[:listing_security_price_accurate]
            reservation_reconstructed_data["total_price"] = reserve[:total_paid_amount_accurate]
        end
        return reservation_reconstructed_data
    end

    def getPhoneDatas(  data, company ) 
        phone_reconstructed_data = []
        num = {}

        if company == 'airbnb'
            num["phone"] = data[:guest][:phone]
            phone_reconstructed_data << num
        end

        if company == 'booking'
            numbers = data[:reservation][:guest_phone_numbers]

            numbers.each do |number|
                num["phone"] = number
                phone_reconstructed_data << num
            end
        end
        return phone_reconstructed_data
    end

    def whichPayload( data )

        if data[:guest].present? and
           data[:guest][:first_name].present? and
           data[:guest][:last_name].present? and
           data[:guest][:phone].present? and
           data[:guest][:email].present? 
            return 'airbnb'
        end

        if data[:reservation].present? and
           data[:reservation][:guest_first_name].present? and
           data[:reservation][:guest_last_name].present? and
           data[:reservation][:guest_phone_numbers].present? and
           data[:reservation][:guest_email].present? and
            return 'booking'
        end
        error_400('Unidentified Payload')
        return nil
    end
    
    def json_response data
        render json: {message: "Success", code:200, data: data}, status: 200
    end

    def error_400 msg
        render json: {message: msg, code:400}, status: 400
    end

    def error_403 msg
        render json: {message: msg, code:403}, status: 403
    end

    def error_404 msg
        render json: {message: msg, code:404}, status: 404
    end
    
    def error_500 msg
        render json: {message: msg, code:500}, status: 500
    end
end
