class Chat < ApplicationRecord
  # Relationships
  belongs_to :application
  has_many :messages

  def next_message_number
    REDIS_CLIENT.incr("messages_count_#{application.token}_#{number}")
  end

  def current_messages_count
    REDIS_CLIENT.get("messages_count_#{application.token}_#{number}") || 0
  end
end
