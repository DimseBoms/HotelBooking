class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show edit update destroy ]

  # GET /reservations or /reservations.json
  def index
    # Filters reservations by hotel_id if the hotel_id parameter is present.
    # it is in the /hotels/:hotel_id/reservations route.
    if !params[:hotel_id].blank?
      @reservations = Hotel.find(params[:hotel_id]).reservations
    else
      @reservations = Reservation.all
    end
  end

  # GET /reservations/1 or /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations or /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully created." }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully updated." }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to reservations_url, notice: "Reservation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    render :search
  end

  def book
    render :book
  end

  def search_results
    if params[:city].blank? || params[:arrival_date].blank? || params[:departure_date].blank? || params[:no_of_rooms].blank? || params[:max_price].blank?
      redirect_to root_url, notice: "Please fill in all the fields"
      return
    end
    if params[:arrival_date] > params[:departure_date]
      redirect_to root_url, notice: "Arrival date must be before departure date"
      return
    end
    if params[:no_of_rooms].to_i <= 0
      redirect_to root_url, notice: "Number of rooms must be greater than 0"
      return
    end
    if params[:max_price].to_i <= 0
      redirect_to root_url, notice: "Max price must be greater than 0"
      return
    end
    if Date.parse(params[:arrival_date]) < Date.today
      redirect_to root_url, notice: "Arrival date cannot be in the past"
      return
    end
    puts "Searching for hotels in #{params[:city]}"
    puts params
    # Convert numbered params to numbers
    params[:no_of_rooms] = params[:no_of_rooms].to_i
    params[:max_price] = params[:max_price].to_i
    # Filter hotels by city
    @hotels = Hotel.where("LOWER(city) = ?", params[:city].downcase)
    # Find hotels that are available between the arrival and departure dates
    if params[:arrival_date] && params[:departure_date]
      @available_hotels = []
      @hotels.each do |hotel|
        # Add the hotel to available_hotels if it has enough rooms and the max price is less than hotel.room_price
        if params[:no_of_rooms] <= hotel.available_rooms(params[:arrival_date], params[:departure_date]) && params[:max_price] >= hotel.room_price
          @available_hotels << hotel
        end
      end
      @hotels = @available_hotels
    end
    render :search_results
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:first_name, :last_name, :phone, :email, :hotel_id, :arrival_date, :departure_date, :no_of_rooms)
    end
end
