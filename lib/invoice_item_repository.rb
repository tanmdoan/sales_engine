require './test/test_helper'


class InvoiceItemRepository
  attr_reader :invoice_items

  def initialize(invoice_items)
    @invoice_items = invoice_items
  end

  def self.load(file='./data/invoice_items.csv')
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      InvoiceItem.new(row)
    end
    new(rows)
  end
end
