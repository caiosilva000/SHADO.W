class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @room = Room.new
    @rooms = Room.all

  end

  def show
    @users = User.all_except(current_user)

    @room = Room.new
    @single_room = Room.find(params[:id])

    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)
    @rooms = Room.where("name ilike ?", "%#{current_user.github_nickname}%")
    render 'rooms/index'
  end

  def create
    @room = Room.new
    @user = User.find(params[:user_id])
    @room.name = get_name(@user, current_user)
    @room.save
    redirect_to room_path(@room)
  end

  def get_name(user1, user2)
    "#{user1.github_nickname} | #{user2.github_nickname}"
    end
end
