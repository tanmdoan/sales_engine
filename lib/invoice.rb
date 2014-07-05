require './test/test_helper'

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
    sales_engine.invoice_item_repository.find_all_by_item_id(id)
  end
end
