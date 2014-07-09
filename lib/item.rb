require 'bigdecimal'
class Item
  attr_reader :id, :name, :description, :unit_price,
              :merchant_id, :created_at, :updated_at, :sales_engine

  def initialize(data, sales_engine)
    @id          = data[:id].to_i
    @name        = data[:name]
    @description = data[:description]
    @unit_price  = convert_to_big_decimal(data[:unit_price])
    @merchant_id = data[:merchant_id].to_i
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @sales_engine = sales_engine
  end

  def invoice_items
    sales_engine.invoice_item_repository.find_all_by_item_id(id)
  end

  def merchant
    sales_engine.merchant_repository.find_by_id(merchant_id)
  end

  def successful_invoice_items
    invoice_items.select { |invoice_item| invoice_item.successful? }
  end

  def revenue
    successful_invoice_items
      .inject(0) { |sum, invoice_item| sum + invoice_item.charged }
  end

  def quantity_sold
    succesful_invoice_items.inject(0) do |sum, invoice_item|
       sum + invoice_item.total_revenue_per_item
    end
  end

  def convert_to_big_decimal(cents)
    BigDecimal.new(convert_cents_to_dollars(cents).to_s)
  end

  def convert_cents_to_dollars(cents)
    cents.to_i/100.00
  end

  def total_revenue_per_item
    invoice_items
      .inject(0) { |sum, invoice_item| sum + invoice_item.charged }
  end
end
