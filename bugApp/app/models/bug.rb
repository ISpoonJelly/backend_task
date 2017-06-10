require 'elasticsearch/model'

class Bug < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings analysis: {
    filter: {
      ngram_filter: { type: "nGram", min_gram: 2, max_gram: 10}
    },
    analyzer: {
      index_ngram_analyzer: {
        type: 'custom',
        tokenizer: 'standard',
        filter: ['lowercase', 'ngram_filter']
      },
      search_ngram_analyzer: {
        type: 'custom',
        tokenizer: 'standard',
        filter: ['lowercase']
      }
    }
  }, index: { number_of_shards: 1 } do
      mapping dynamic: false do
        indexes :appToken, index: 'not_analyzed'
        indexes :number, index: 'not_analyzed'
        indexes :status, index: 'not_analyzed'
        indexes :priority, index: 'not_analyzed'
        indexes :comment, analyzer: 'index_ngram_analyzer', search_analyzer: "search_ngram_analyzer"
      end
  end

  belongs_to :state, :dependent => :delete

  enum status: [:fresh, :in_progress, :closed]
  enum priority: [:minor, :major, :critical]

  validates :appToken, :number, :status, :priority, :comment, :state_id, :presence => true
  validates :number, uniqueness: { scope: [:appToken] }

  def as_indexed_json(options = {})
    self.as_json({
      only: [:appToken, :number, :status, :priority, :comment],
      include: {
         state: { only: [:device, :os, :memory, :storage] }
      }
    })
  end

  def self.search(query)
    self.__elasticsearch__.search({
      query: {
        multi_match: {
          query: query,
          fields: [:appToken, :number, :status, :priority, :comment, :device, :os, :memory, :storage ]
        }
      }
    }).records
  end
end

Bug.__elasticsearch__.create_index! rescue nil
Bug.import! rescue nil
