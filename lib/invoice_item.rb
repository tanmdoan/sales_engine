require 'bigdecimal'
require_relative '../lib/decimal_conversion'

class InvoiceItem
  attr_reader :id, :item_id, :invoice_id, :quantity,
              :unit_price, :created_at, :updated_at, :sales_engine

  include DecimalConversion

  def initialize(data, sales_engine)
    @id         = data[:id].to_i
    @item_id    = data[:item_id].to_i
    @invoice_id = data[:invoice_id].to_i
    @quantity   = data[:quantity].to_i
    @unit_price = convert_to_big_decimal(data[:unit_price])
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @sales_engine = sales_engine
  end

  def item
    sales_engine.item_repository.find_by_id(item_id)
  end

  def invoice
    sales_engine.invoice_repository.find_by_id(invoice_id)
  end

  def successful?
    invoice.successful?
  end

  def charged
    quantity * unit_price
  end

end
