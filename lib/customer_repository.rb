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
end
