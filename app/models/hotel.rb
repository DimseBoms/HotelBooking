class Hotel < ApplicationRecord
  has_many :reservations, dependent: :destroy

  validates :name, presence: true
  validates :city, presence: true
  validates :number_of_rooms, presence: true
  validates :room_price, presence: true

  # Find amount of available rooms between the arrival and departure dates
  def available_rooms(arrival_date, departure_date)
    puts "Searching for available rooms between #{arrival_date} and #{departure_date}"
    reservations = 0
    begin
      arrival_date = Date.parse(arrival_date) # convert arrival_date to date object
      departure_date = Date.parse(departure_date) # convert departure_date to date object
      self.reservations.each do |reservation|
        puts "Checking reservation #{reservation.id}"
        if reservation.arrival_date < departure_date && reservation.departure_date > arrival_date
          puts "Reservation #{reservation.id} is in the way!"
          reservations += reservation.no_of_rooms
        end
      end
      self.number_of_rooms - reservations
    rescue ArgumentError # handle invalid date error
      0
    end
  end
end
