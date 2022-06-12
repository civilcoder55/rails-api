class Message < ApplicationRecord
  # Validations
  validates :body, presence: true
  # Relationships
  belongs_to :chat
end
