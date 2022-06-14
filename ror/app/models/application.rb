class Application < ApplicationRecord
  # Validations
  validates :name, presence: true, length: { minimum: 4, maximum: 255 }

  # Relationships
  has_many :chats

  # Callbacks
  before_create :generate_token

  def next_chat_number
    REDIS_CLIENT.incr("chats_count_#{token}")
  end

  def current_chats_count
    REDIS_CLIENT.get("chats_count_#{token}") || 0
  end

  private

  def generate_token
    # generate sha1 hash from a secure random hexadecimal string + today date to add more randomness
    self.token = (Digest::SHA1.hexdigest "#{SecureRandom.hex(10)}-#{DateTime.now}")
  end
end
