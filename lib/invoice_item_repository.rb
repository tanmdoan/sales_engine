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

  def find_by_id(id)
    id = id.to_s
    invoice_items.select do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_by_item_id(item_id)
    item_id = item_id.to_s
    invoice_items.select do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_by_invoice_id(invoice_id)
    invoice_id = invoice_id.to_s
    selected = []
    invoice_items.detect do |invoice_item|
      selected << invoice_item if invoice_item.invoice_id == invoice_id
    end
    selected
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_id = invoice_id.to_s
    invoice_items.select do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def find_by_quantity(quantity)
    quantity = quantity.to_s
    selected = []
    invoice_items.detect do |invoice_item|
      selected << invoice_item if invoice_item.quantity == quantity
    end
    selected
  end

  def find_all_by_quantity(quantity)
    quantity = quantity.to_s
    invoice_items.select do |invoice_item|
      invoice_item.quantity == quantity
    end
  end

  def find_by_unit_price(unit_price)
    unit_price = unit_price.to_s
    selected = []
    invoice_items.detect do |invoice_item|
      selected << invoice_item if invoice_item.unit_price == unit_price
    end
    selected
  end

  def find_all_by_unit_price(unit_price)
    unit_price = unit_price.to_s
    invoice_items.select do |invoice_item|
      invoice_item.unit_price == unit_price
    end
  end

  def random
    selected = []
    selected << invoice_items.sample
    selected
  end
end
