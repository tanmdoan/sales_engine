require 'csv'
require_relative 'customer'

class CustomerRepository
  attr_reader :customers, :sales_engine

  def initialize(customers)
    @customers = customers
  end

  def self.load(sales_engine, file='./data/customers.csv')
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Customer.new(row, sales_engine)
    end
    new(rows)
  end

  def find_by_id(id)
    results = customers.detect do |customer|
      customer.id == id
    end
  end

  def find_by_first_name(first_name)
    customers.detect do |customer|
      customer.first_name == first_name
    end
  end

  def find_by_last_name(last_name)
    customers.detect do |customer|
      customer.last_name == last_name
    end
  end

  def find_all_by_first_name(first_name)
    customers.select do |customer|
      customer.first_name == first_name
    end
  end

  def find_all_by_last_name(lastname)
    customers.select do |customer|
      customer.last_name == lastname
    end
  end

  def random
    customers.sample
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

end
