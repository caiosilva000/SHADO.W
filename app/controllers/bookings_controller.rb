class BookingsController < ApplicationController
  def new
    @booking = Booking.new(duration: 1)
    @booker = User.find(params[:user_id])
    @available_dates = @booker.availabilities.map do |availability|
      {
        from: availability.start_date.to_date, to: availability.end_date.to_date
      }
    end
  end

  def show
    @booking.bookee = current_user
    @booker = User.find(params[:user_id])
    @booking.booker = @booker
  end

  def index
    @bookings = Booking.all

  end

  def create
    @booking = Booking.new(booking_params)
    @booking.bookee = current_user
    @booking.end_date = @booking.start_date + @booking.duration.hours
    @booker = User.find(params[:user_id])
    @booking.booker = @booker
    @availability = Availability.create(user: @booker, start_date: params[:booking][:start_date], end_date: params[:booking][:end_date])
    @booking.availability = @availability
    if @booking.save
      redirect_to user_path(current_user), notice: 'Booking was successfully created.'
    else
    end
  end

  def thank_you
    @booking = Booking.find(params[:id])
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :duration)
  end

end
