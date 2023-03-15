class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @room = Room.new
    @rooms = Room.all
    @users = User.all_except(current_user)
  end

  def show
    @user = User.find(params[:id])
    @users = User.all_except(current_user)

    @room = Room.new
    @rooms = Room.public_rooms
    @room_name = get_name(@user, current_user)
    @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, current_user], @room_name)

    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)
    render 'rooms/index'
  end

  def create
    @room = Room.create(name: params["room"] ["name"])
  end


end
