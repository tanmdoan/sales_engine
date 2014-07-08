require 'bigdecimal'# require 'unit_conversion'

class InvoiceItem
  attr_reader :id, :item_id, :invoice_id, :quantity,
              :unit_price, :created_at, :updated_at, :sales_engine

  # include UnitConversion

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

  def convert_to_big_decimal(cents)
    BigDecimal.new(convert_cents_to_dollars(cents).to_s)
  end

  def convert_cents_to_dollars(cents)
    cents.to_i/100.00
  end

  def charged
    quantity * unit_price
  end

end
