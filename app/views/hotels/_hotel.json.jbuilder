json.extract! hotel, :id, :name, :city, :number_of_rooms, :room_price, :created_at, :updated_at
json.url hotel_url(hotel, format: :json)
