class BugWorker
  include Sneakers::Worker
  from_queue :bugs, :exchange => 'amq.direct', :routing_key => 'new_bug'

  def work(message)
    if BugConsumer.new().process(message)
      ack!
    end
  end
end
