require './test/test_helper'

class CustomerRepository
 attr_reader :customers

 def initialize(customers)
   @customers = customers
 end

 def self.load(file='./data/customers.csv')
   data = CSV.open(file, headers: true, header_converters: :symbol)
   rows = data.map do |row|
     Customer.new(row)
   end
   new(rows)
 end

 def find_by_id(id)
   id = id.to_s
   results = customers.select do |customer|
     customer.id == id
   end
   binding.pry
 end

 def find_by_id(id)
   id = id.to_s
   customers.select do |customer|
     customer.id == id
   end
 end

 def find_by_first_name(firstname)
   name = name.to_s
   selected = []
   customers.detect do |customer|
     selected << customer if customer.first_name == firstname
   end
   selected
 end

 def find_by_last_name(lastname)
   name = name.to_s
   selected = []
   customers.detect do |customer|
     selected << customer if customer.last_name == lastname
   end
   selected
 end

 def find_all_by_first_name(firstname)
   name = name.to_s
   customers.select do |customer|
     customer.first_name == firstname
   end
 end

 def find_all_by_last_name(lastname)
   name = name.to_s
   customers.select do |customer|
     customer.last_name == lastname
   end
 end

 def random
   selected = []
   selected << customers.sample
   selected
 end

end
