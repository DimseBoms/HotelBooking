require "application_system_test_case"

class ReservationsTest < ApplicationSystemTestCase
  setup do
    @reservation = reservations(:one)
  end

  test "visiting the index" do
    visit reservations_url
    assert_selector "h1", text: "Reservations"
  end

  test "should create reservation" do
    visit reservations_url
    click_on "New reservation"

    fill_in "Arrival date", with: @reservation.arrival_date
    fill_in "Departure date", with: @reservation.departure_date
    fill_in "Email", with: @reservation.email
    fill_in "First name", with: @reservation.first_name
    fill_in "Hotel", with: @reservation.hotel_id
    fill_in "Last name", with: @reservation.last_name
    fill_in "No of rooms", with: @reservation.no_of_rooms
    fill_in "Phone", with: @reservation.phone
    click_on "Create Reservation"

    assert_text "Reservation was successfully created"
    click_on "Back"
  end

  test "should update Reservation" do
    visit reservation_url(@reservation)
    click_on "Edit this reservation", match: :first

    fill_in "Arrival date", with: @reservation.arrival_date
    fill_in "Departure date", with: @reservation.departure_date
    fill_in "Email", with: @reservation.email
    fill_in "First name", with: @reservation.first_name
    fill_in "Hotel", with: @reservation.hotel_id
    fill_in "Last name", with: @reservation.last_name
    fill_in "No of rooms", with: @reservation.no_of_rooms
    fill_in "Phone", with: @reservation.phone
    click_on "Update Reservation"

    assert_text "Reservation was successfully updated"
    click_on "Back"
  end

  test "should destroy Reservation" do
    visit reservation_url(@reservation)
    click_on "Destroy this reservation", match: :first

    assert_text "Reservation was successfully destroyed"
  end
end
