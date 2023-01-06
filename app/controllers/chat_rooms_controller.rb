class ChatRoomsController < ApplicationController
  def create
    message_partner = User.find(params[:user_id])
    return unless current_user.interactive_follow?(message_partner)

    relationship = Relationship.get_relationship_for_chat_room(current_user, message_partner
    )
    chat_room = ChatRoom.create!(relationship: relationship)

    redirect_to chat_room_path(chat_room)
  end

  def show
    @chat_room = ChatRoom.find(params[:id])
    @messages = @chat_room.messages.order(:created_at)
    @message = Message.new
  end

  private

  def message_available?(user)
    current_user.following_users.include?(user) &&
    current_user.followed_users.include?(user)
  end
end
