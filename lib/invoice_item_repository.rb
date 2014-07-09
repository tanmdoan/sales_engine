require 'csv'
require_relative 'invoice_item'


class InvoiceItemRepository
  attr_reader :invoice_items, :sales_engine

  def initialize(invoice_items)
    @invoice_items = invoice_items
  end

  def self.load(sales_engine, file='./data/invoice_items.csv')
    data = CSV.open(file, headers: true, header_converters: :symbol)
      rows = data.map do |row|
      InvoiceItem.new(row, sales_engine)
    end
    new(rows)
  end

  def find_by_id(id)
    invoice_items.detect do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_by_item_id(item_id)
    invoice_items.detect do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_item_id(item_id)
    invoice_items.select do |invoice_item|
      invoice_item.item_id == item_id
    end

  end

  def find_by_invoice_id(invoice_id)
    invoice_items.detect do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items.select do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def find_by_quantity(quantity)
    invoice_items.detect do |invoice_item|
      invoice_item.quantity == quantity
    end
  end

  def find_all_by_quantity(quantity)
    invoice_items.select do |invoice_item|
      invoice_item.quantity == quantity
    end
  end

  def find_by_unit_price(unit_price)
    invoice_items.detect do |invoice_item|
      invoice_item.unit_price == unit_price
    end
  end

  def find_all_by_unit_price(unit_price)
    invoice_items.select do |invoice_item|
      invoice_item.unit_price == unit_price
    end
  end

  def random
    invoice_items.sample
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end
end
