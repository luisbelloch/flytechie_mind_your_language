require 'active_record'
require 'pg'
require 'yaml'

configuration = YAML::load(File.open("#{__dir__}/database.yml"))
ActiveRecord::Base.establish_connection(configuration)

module Orders
  class Order < ActiveRecord::Base
  end
end
