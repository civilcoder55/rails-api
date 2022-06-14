class Message < ApplicationRecord
  # Validations
  validates :body, presence: true

  # Relationships
  belongs_to :chat

  # Elasticsearch
  include Searchable

  # Elasticsearch Mapping
  settings @@elastic_search_settings do
    mappings dynamic: false do
      indexes :id, type: :integer, index: false
      indexes :application_token, type: :keyword
      indexes :chat_number, type: :keyword
      indexes :number, type: :integer, index: false
      indexes :body, type: :text, analyzer: :custom_analyzer
      indexes :created_at, type: :date, index: false
      indexes :updated_at, type: :date, index: false
    end
  end

  def as_indexed_json(_options = {})
    {
      id: id,
      application_token: chat.application.token,
      chat_number: chat.number,
      number: number,
      body: body,
      created_at: created_at,
      updated_at: updated_at
    }
  end

  def self._search(application_token, chat_number, query)
    search({ query: {
             bool: {
               must: [{ match: { body: query } }],
               filter: [
                 { term: { application_token: application_token } },
                 { term: { chat_number: chat_number } }
               ]
             }
           } }).results
  end
end
