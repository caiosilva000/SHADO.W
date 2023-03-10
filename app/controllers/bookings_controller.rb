class BookingsController < ApplicationController

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @bookee = Bookee.find(params[:bookee_id])
    @booking.bookee = @bookee

    if @booking.save!
      redirect_to my_profile_booking_path(@bookee, @booking)
    else
      render :new
    end
  end
end
