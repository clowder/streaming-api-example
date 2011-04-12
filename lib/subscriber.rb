require 'eventmachine'
require 'ruby-debug'

class Subscriber 
  include EventMachine::Deferrable 

  def initialize
    @queue        = EventMachine::Queue.new
    @queue_runner = Proc.new do |chunk|
      @callback.call(chunk, chunk.bytes.count)
      @queue.pop &@queue_runner
    end

    @queue.pop &@queue_runner
  end

  def left
    @left
  end

  def <<(chunk)
    @queue.push(chunk)
  end

  def each(&block)
    @callback = block
    self << "Welcome to the streaming API\n"

    # Keep the connection alive if we aren't sending any data
    timer = EventMachine::PeriodicTimer.new(20) do 
      @callback.call("\n", 1)
    end

    # Stop the keep-alive and set the subscriber to left
    errback do 
      timer.cancel
      @left = true
    end
  end
end
