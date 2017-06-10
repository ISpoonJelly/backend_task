config = {
  host: 'elasticsearch',
  log: true
}

Elasticsearch::Model.client = Elasticsearch::Client.new(config)
