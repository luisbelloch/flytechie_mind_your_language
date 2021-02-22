require 'faraday'
require 'json'
require 'ksuid'
require 'nats/client'

class Iterfable
  URL = 'http://127.0.0.1:3000/email'.freeze

  def self.send(event)
    Faraday.post(URL, event.to_json, "Content-Type" => "application/json")
    print('*')
  end
end

NATS.start(:servers => ['nats://127.0.0.1:4222']) do
  puts 'Consuming pancakes...'
  NATS.subscribe('pancake.*') do |raw|
    print('.')
    event = JSON.parse(raw)
    Iterfable.send(event.merge(track_id: KSUID.new, ts: Time.now))
  end
end

