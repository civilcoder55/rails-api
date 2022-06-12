class Chat < ApplicationRecord
  # Relationships
  belongs_to :application
  has_many :messages
end
