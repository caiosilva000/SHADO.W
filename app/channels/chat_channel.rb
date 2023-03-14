class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_room_#{params[:id]}"
  end

  def speak(data)
    message = Message.create(content: data['message'], user: current_user, chat_room_id: params[:id])
    ChatChannel.broadcast_to "chat_room_#{params[:id]}", message: render_message(message)
  end

  private

  def render_message(message)
    ApplicationController.render(partial: 'messages/message', locals: { message: message })
  end
end
