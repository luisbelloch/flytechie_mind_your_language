require 'hanami/router'
require_relative './orders'

class App
  def self.run
    Hanami::Router.new do
      post '/orders/create', to: Orders::Create
    end
  end
end
