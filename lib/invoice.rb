
class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :sales_engine

  def initialize(data, sales_engine)
    @id          = data[:id]
    @customer_id = data[:customer_id]
    @merchant_id = data[:merchant_id]
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
    sales_engine.customer_repository.find_by_id(id)
  end

  def merchant
    sales_engine.merchant_repository.find_by_id(id)
  end

end
