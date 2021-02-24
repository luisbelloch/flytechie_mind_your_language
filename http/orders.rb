require 'ksuid'
require 'json'
require 'hanami/controller'
require 'hanami/middleware/body_parser'
require_relative './storage'

module Orders
  class Create
    include Hanami::Action
    use Hanami::Middleware::BodyParser, :json

    def call(params)
      order = { id: KSUID.new.to_s, flavour: params[:flavour], size: params[:size] }
      Order.create!(order)

      self.status  = 201
      self.body    = order.to_json
    end
  end
end
