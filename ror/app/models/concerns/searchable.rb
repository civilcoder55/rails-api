module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
  end

  @@elastic_search_settings = {
    analysis: {
      filter: {
        autocomplete_filter: {
          type: 'edge_ngram',
          min_gram: 1,
          max_gram: 10
        }
      },
      analyzer: {
        custom_analyzer: {
          type: 'custom',
          tokenizer: 'standard',
          filter: %w[lowercase autocomplete_filter]
        }
      }
    }
  }
end
