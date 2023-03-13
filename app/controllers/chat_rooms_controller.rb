class ChatRoomsController < ApplicationController
  def create
    @chat_room = ChatRoom.new(chat_room_params)
    authorize ChatRoom, :create?

    if @chat_room.save
      redirect_to @chat_room
    else
      render :new
    end
  end

  def destroy
    @chat_room = ChatRoom.find(params[:id])
    authorize @chat_room, :destroy?

    @chat_room.destroy
    redirect_to chat_rooms_path
  end
  def show
    @chat_rooms = Chatroom.all
    @chat_room = Chatroom.find_by(id: params[:id])
    if @chat_room
      @messages = @chat_room.messages.includes(:user)
    else
      # Handle case where Chatroom with given id does not exist
    end
  end

  def index
    @chat_rooms = Chatroom.all
  end
  private

  def chat_room_params
    params.require(:chat_room).permit(:name)
  end
end
