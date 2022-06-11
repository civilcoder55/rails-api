class Application < ApplicationRecord
  # Validations
  validates :name, presence: true, length: { minimum: 4, maximum: 255 }
  # Relationships
  has_many :chats
  # Callbacks
  before_create :generate_token

  private

  def generate_token
    # generate sha1 hash from a secure random hexadecimal string + today date to add more randomness
    self.token = (Digest::SHA1.hexdigest "#{SecureRandom.hex(10)}-#{DateTime.now}")
  end
end
