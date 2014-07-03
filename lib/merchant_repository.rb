require './test/test_helper'

class MerchantRepository

   attr_reader :merchants, :sales_engine

   def initialize(merchants)
     @merchants = merchants
   end

   def self.load(sales_engine, file='./data/fixtures/merchants_sample.csv')
     data = CSV.open(file, headers: true, header_converters: :symbol)
     rows = data.map do |row|
       Merchant.new(row, sales_engine)
     end
     new(rows)
   end

   def find_by_id(id)
     id = id.to_s
     merchants.select do |merchant|
       merchant.id == id
     end
   end

   def find_by_name(name)
     name = name.to_s
     selected = merchants.detect do |merchant|
       merchant.name == name
     end
     selected
   end

   def find_all_by_name(name)
     name = name.to_s
     merchants.select do |merchant|
       merchant.name == name
     end
   end

   def random
     selected = []
     selected << merchants.sample
     selected
   end
end
