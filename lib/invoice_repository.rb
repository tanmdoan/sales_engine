require 'csv'
require './lib/invoice'

class InvoiceRepository
  attr_reader :invoices

  def initialize(invoices)
    @invoices = invoices
  end

  def self.load(file)
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Invoice.new(row)
    end
    new(rows)
  end
end
