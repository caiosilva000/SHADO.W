class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]
  def home
  end

  def create
    @user = User.new(user_params)
    authorize @user

    if @user.save
      redirect_to @user
    else
      render :new
    end
  end
  
  def my_profile
    @user = current_user
    render 'show'
  end

  def my_bookings
    @bookings = Booking.where(booker: current_user)
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    if params[:query].present?
      sql_query = "user_name ILIKE :query OR github_nickname ILIKE :query"
      @users = User.where(sql_query, query: "%#{params[:query]}%")
    else
      @users = User.all
    end
  end
end
