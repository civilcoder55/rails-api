Elasticsearch::Model.client = Elasticsearch::Client.new(log: false,
                                                        host: ENV['ELASTICSEARCH_HOST'],
                                                        retry_on_failure: true)
