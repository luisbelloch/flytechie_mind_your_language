require 'hanami/controller'

module Orders
  class Create
    include Hanami::Action

    def call(params)
      self.status  = 201
      self.body    = 'Hi!'
    end
  end
end
