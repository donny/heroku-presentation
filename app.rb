require 'sinatra/base'
require 'json'

class SimpleApp < Sinatra::Base
    get '/hello' do
        value = ["hello", "world"]
        content_type :json
        return value.all.to_json
    end
end
