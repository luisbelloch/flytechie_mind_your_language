require 'csv'
require 'securerandom'

countries = CSV.read('./country_codes.csv', headers: true)
country_codes = countries.map { |c| c['code'] }

CSV.open("./pancake_orders.10M.csv", "wb") do |csv|
  csv << ["ts", "price", "item_count","source_country","coupon_code"]

  count = [1,1,1,1,1,2,2,3,4,5,6]
  prices = Array.new(15) { |i| rand(1..12.0).truncate(2) }

  now = Time.now
  (1..10_000_000).each do |i|
    now = now + (60 * rand(0..2.0))
    coupon_code = SecureRandom.hex(3) if rand > 0.9
    csv << [now.strftime("%Y-%m-%dT%H:%M:%S.%L"), prices.sample, count.sample, country_codes.sample, coupon_code]
  end
end
