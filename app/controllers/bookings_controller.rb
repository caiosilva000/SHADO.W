class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @booker = User.find(params[:user_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.bookee = current_user
    # This is a hard coded avalibility change later
    @booking.availability = Availability.first
    @booker = User.find(params[:user_id])
    @booking.booker = @booker

    if @booking.save
      redirect_to thank_you_booking_path(@booking)
    else
      render :new
    end
  end

  def thank_you
    @booking = Booking.find(params[:id])
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
