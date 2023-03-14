class PaymentsController < ApplicationController
  def new
    @booking = Booking.find(params[:booking_id])
    @payment = Payment.new(booking: @booking, total_price: @booking.price)
  end

  def create
    @booking = Booking.find(params[:booking_id])
    @payment = Payment.new(payment_params)
    @payment.booking = @booking

    if @payment.save
      redirect_to thank_you_booking_path(@booking)
    else
      render :new
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:first_name, :last_name, :email, :phone, :card_number, :cvc, :expiration_month, :expiration_year, :total_price)
  end
end
