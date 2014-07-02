require './test/test_helper'


class CustomerParser
    attr_reader :parse
  def initialize(parse)
    @parse = parse
  end

  def self.load(file='./data/customers.csv')
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Customer.new(row)
    end
    new(rows)
  end
end
