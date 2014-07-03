require './test/test_helper'
# require 'pry'
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
 end

 def find_by_id(id)
   id = id.to_s
   customers.select do |customer|
     customer.id == id
   end
 end

 def find_by_first_name(first_name)
   first_name = first_name.to_s
   selected = []
   customers.detect do |customer|
     selected << customer if customer.first_name == first_name
   end
   selected
 end

 def find_by_last_name(last_name)
   last_name = last_name.to_s
   selected = []
   customers.detect do |customer|
     selected << customer if customer.last_name == last_name
   end
   selected
 end

 def find_all_by_first_name(first_name)
   first_name = first_name.to_s
   customers.select do |customer|
     customer.first_name == first_name
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
