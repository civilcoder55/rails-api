module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
  end

  @@elastic_search_settings = {
    analysis: {
      analyzer: {
        custom_analyzer: {
          type: 'custom',
          tokenizer: 'standard',
          filter: %w[lowercase]
        }
      }
    }
  }
end
