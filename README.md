# ElasticSearch ruby client

ElasticSearch ruby client. Credit goes to my coworkers at GitHub, I just turned it into a gem.

## Usage

Add to Gemfile

    gem 'elasticsearch-client', :require => 'elasticsearch'

Create connection:

    index = 'twitter'
    url = 'http://localhost:9200'
    es = ElasticSearch::Index.new(index, url)

Index a document:

    type = 'tweet'
    doc = {:id => 'abcd', :foo => 'bar'}
    es.add(type, doc[:id], doc)

Get a document:

    id = '1234'
    es.mget(type, [id])

Get documents:

    id2 = 'abcd'
    es.mget(type, [id, id2])

Search:

    query = {
      :query => {
        :bool => {
          :must => {
            :query_string => {
              :default_field => '_all',
              :query => 'foobar!',
            }
          }
        }
      }
    }
    es.search(type, query)

Remove record:

    es.remove(type, id)

Remove by query:

    es.remove_by_query(type, :term => {:foo => 'bar'})

Remove all of type:

    es.remove_all(type)

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so we don't break it in a future version unintentionally.
* Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine, but bump version in a commit by itself so we can ignore when we pull)
* Send us a pull request. Bonus points for topic branches.