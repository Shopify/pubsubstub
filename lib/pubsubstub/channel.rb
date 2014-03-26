module Pubsubstub
  class Channel
    attr_reader :name

    def initialize(name, pubsub)
      @name = name
      @pubsub = pubsub
      @connections = []
    end

    def subscribe(connection)
      # logger.debug "[Channel] Subscribing #{id} to #{@name}"
      listen if @connections.empty?
      @connections << connection
    end

    def subscribed?(connection)
      @connections.include?(connection)
    end

    def unsubscribe(connection)
      @connections.delete(connection)
      stop_listening if @connections.empty?
    end

    def publish(event)
      # logger.debug "[Channel] Publishing to #{@name}"
      @clients.each do |connection|
        callback.call(@name, *args)
      end
    end

    private
    def broadcast(message)
    end

    def listen
      @pubsub.subscribe(name, method(:broadcast))
    end

    def stop_listening
      @pubsub.unsubscribe(name, method(:broadcast))
    end
  end
end