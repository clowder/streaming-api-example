$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'sinatra/async'
require 'subscriber'
require 'ruby-debug'

class Server < Sinatra::Base
  register Sinatra::Async

  subscribers = []
  
  aget '/' do
    subscriber =  Subscriber.new
    subscribers << subscriber
    body subscriber
    body
  end

  post '/' do
    message = params[:message]
    subscribers.each { |sub| sub << message }
    body "Message Sent to Subscribers!"
  end
end
