class AvailabilitiesController < ApplicationController

  def new
    @availability = Availability.new
  end

  def create
    @availability = Availability.new(availability_params)
    @availability.user = current_user
    if @availability.save
      redirect_to my_bookings_path
    else
      render :new
    end
  end

  private

  def availability_params
    params.require(:availability).permit(:start_date, :end_date)
  end
end
