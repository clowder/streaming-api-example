require 'eventmachine'
require 'ruby-debug'

class Subscriber 
  include EventMachine::Deferrable 

  def <<(chunk)
    @callback.call(chunk, chunk.bytes.count)
  end

  def each(&block)
    @callback = block
  end
end
