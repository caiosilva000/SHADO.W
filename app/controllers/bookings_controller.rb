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
      redirect_to my_bookings_path
    else
      render :new
    end
  end

  def pay_booking
    @booking = Booking.find(params[:id])
    @payment = Payment.new(booking: @booking, total_price: @booking.price)
  end

  def create_payment
    @booking = Booking.find(params[:booking_id])
    @payment = Payment.new(payment_params)
    @payment.booking = @booking

    if @payment.save
      redirect_to thank_you_booking_path(@booking)
    else
      render :pay
    end
  end

  def thank_you
    @booking = Booking.find(params[:id])
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def payment_params
    params.require(:payment).permit(:first_name, :last_name, :email, :phone, :card_number, :cvc, :expiration_month, :expiration_year, :total_price)
  end
end
