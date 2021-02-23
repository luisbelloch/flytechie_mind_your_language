require 'csv'

total_by_country = {}
CSV.foreach('./pancake_orders.1M.csv', headers: true) do |line|
  price = line['price'].to_f
  country = line['source_country']
  total_by_country[country] = price + (total_by_country[country] || 0.0)
end
puts total_by_country
