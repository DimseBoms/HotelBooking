class Reservation < ApplicationRecord
  belongs_to :hotel

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :hotel_id, presence: true
  validates :arrival_date, presence: true
  validates :departure_date, presence: true
  validates :no_of_rooms, presence: true
  validate :arrival_not_in_the_past
  validate :arrival_before_departure
  validate :hotel_not_full

  private

  def arrival_before_departure
    if arrival_date.present? && departure_date.present? && arrival_date > departure_date
      errors.add(:arrival_date, "can't be after departure date")
    end
  end

  def arrival_not_in_the_past
    if arrival_date.present? && arrival_date < Date.today
      errors.add(:arrival_date, "can't be in the past")
    end
  end

  def hotel_not_full
    puts "Starting hotel_not_full validation"
    if hotel_id.present?
      puts "Checking if hotel is full"
      if no_of_rooms > hotel.available_rooms(arrival_date, departure_date)
        errors.add(:no_of_rooms, "can't be greater than available rooms")
      end
    end
  end
end
