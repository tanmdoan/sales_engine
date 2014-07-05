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
    # invoice_item = invoice_items.pop
    # id = invoice_item.item_id
    # sales_engine.item_repository.find_by_id(id)
    invoice_items.map(&:item)
    # item_ids.map {|item_id| sales_engine.item_repository.find_by_id(item_id)}
  end

  def customer
    sales_engine.customer_repository.find_by_id(id)
  end

  def merchant
    sales_engine.merchant_repository.find_by_id(id)
  end

end
