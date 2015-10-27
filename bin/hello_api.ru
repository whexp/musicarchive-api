#!/usr/bin/env ruby
require "hello_api"
require "rack/cors"

use Rack::Cors do
  allow do
    origins '*'
    resource '*', :headers => :any, :methods => [:get, :post, :options]
  end
end

run HelloAPI
