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
      if arrival_date.is_a?(String)
        arrival_date = Date.parse(arrival_date) # convert arrival_date to date object
      end
      if departure_date.is_a?(String)
        departure_date = Date.parse(departure_date) # convert departure_date to date object
      end
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

  # Get the amount of occupied rooms on this given day
  def occupied_rooms
    reservations = 0
    self.reservations.each do |reservation|
      if reservation.arrival_date <= Date.today && reservation.departure_date >= Date.today
        reservations += reservation.no_of_rooms
      end
    end
    reservations
  end
end
