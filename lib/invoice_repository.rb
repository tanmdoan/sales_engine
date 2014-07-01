require './test/test_helper'

class InvoiceRepository
  attr_reader :invoices

  def initialize(invoices)
    @invoices = invoices
  end

  def self.load(file ='./data/invoices.csv')
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Invoice.new(row)
    end
    new(rows)
  end
end
