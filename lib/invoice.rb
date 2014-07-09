
class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :sales_engine

  def initialize(data, sales_engine)
    @id          = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status      = data[:status]
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @sales_engine = sales_engine
  end


  def transactions
    sales_engine.transaction_repository.find_all_by_invoice_id(id)
  end

  def invoice_items
    sales_engine.invoice_item_repository.find_all_by_invoice_id(id)
  end

  def items
    invoice_items.map(&:item)
  end

  def customer
    sales_engine.customer_repository.find_by_id(customer_id)
  end

  def quantity
    invoice_items.inject(0){|sum, invoice_item| sum + invoice_item.quantity}
  end

  def merchant
    sales_engine.merchant_repository.find_by_id(merchant_id)
  end

  def successful?
    transactions.any?(&:successful?)
  end

  def invoice_items_total
    invoice_items.inject(0) {|sum, invoice_items| sum + invoice_items.charged}
  end

  def pending?
    transactions.all?(&:pending?)
  end

end
