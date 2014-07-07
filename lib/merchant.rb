class Merchant
  attr_reader :id, :name, :created_at, :updated_at,
              :sales_engine

  def initialize(data, sales_engine)
    @id           = data[:id]
    @name         = data[:name]
    @created_at   = data[:created_at]
    @updated_at   = data[:updated_at]
    @sales_engine = sales_engine
  end

  def items
    sales_engine.item_repository.find_all_by_merchant_id(id)
  end

  def invoices
    sales_engine.invoice_repository.find_all_by_merchant_id(id)
  end

  def all_successful_invoices
    invoices.select do |invoice|
      invoice.status == "shipped"
    end
  end

  def all_successful_invoices_by_date(date)
    all_successful_invoices.select do |invoice|
      Date.parse(invoice.created_at) == date
    end


  def revenue
    all_successful_invoices.inject(0) do |sum, invoice_item|
      sum += invoice_item.charged
    end
  end




end
