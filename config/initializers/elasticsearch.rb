Elasticsearch::Model.client = Elasticsearch::Client.new({
  url: ENV['ELASTICSEARCH_CLUSTER'],
  # log: true
})
