require './test/test_helper'



class InvoiceParser
    attr_reader :parse
  def initialize(parse)
    @parse = parse
  end

  def self.load(file='./data/invoices.csv')
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Invoice.new(row, self)
    end
    new(rows)

  end
end
