class MessagesController < ApplicationController
  def create
    @chat_room = ChatRoom.find(params[:chat_room_id])
    @message = Message.new(message_params)
    @message.from_id = current_user.id
    @message.chat_room_id = @chat_room.id

    if @message.save
      redirect_to chat_room_path(@chat_room)
    else
      @messages = @chat_room.messages.order(:created_at)
      render template: 'chat_rooms/show'
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
