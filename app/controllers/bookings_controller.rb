class BookingsController < ApplicationController

  def new

    @booking = Booking.new
    @booker = User.find(params[:user_id])
    @available_dates = @booker.availabilities.map do |availability|
      {
        from: availability.start_date.to_date, to: availability.end_date.to_date
      }
    end
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.bookee = current_user
    @booking.end_date = @booking.start_date + @booking.duration.hours
    # This is a hard coded avalibility change later
    @booker = User.find(params[:user_id])
    @booking.availability = Availability.find_by(user: @booker)

    @booking.booker = @booker

    if @booking.save
      redirect_to my_bookings_path
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :duration)
  end
end
