require 'json'
require 'nats/client'

NATS.start do
  types = ['initiated', 'cooking', 'delivering', 'delivered']
  loop do
    type = "pancake.#{types.sample}"
    puts type
    NATS.publish('foo', 'Hello World!')
    NATS.publish(type, { type: type, ts: Time.now }.to_json)
    sleep 1
  end
end
