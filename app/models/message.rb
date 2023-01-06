class Message < ApplicationRecord
  belongs_to :chat_room

  validates :body, length: { in: 1..140 }
end
