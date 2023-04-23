json.extract! reservation, :id, :first_name, :last_name, :phone, :email, :hotel_id, :arrival_date, :departure_date, :no_of_rooms, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
