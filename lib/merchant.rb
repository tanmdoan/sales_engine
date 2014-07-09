class Merchant
  attr_reader :id, :name, :created_at, :updated_at,
              :sales_engine

  def initialize(data, sales_engine)
    @id           = data[:id].to_i
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

  def successful_invoices
    invoices.select {|invoice| invoice.successful?}
  end

  def successful_invoice_dates(date)
    successful_invoices.select do |invoice|
      Date.parse(invoice.created_at) == date
    end
  end

  def revenue_with_date(date)
    successful_invoice_dates(date).inject(0) do |sum, invoice|
       sum + invoice.invoice_items_total
    end
  end

  def revenue(date = nil)
    if date.nil?
      revenue_without_date
    else
      revenue_with_date(date)
    end
  end

  def revenue_without_date
    successful_invoices.inject(0) do |sum, invoice|
      sum + invoice.invoice_items_total
    end
  end

  def favorite_customer
    successful_invoices.group_by do |invoice|
      invoice.customer_id
    end.max_by do |customer|
      customer[1].count
    end[-1][0].customer
  end

  def pending_invoices
    invoices.select {|invoice| invoice.pending?}
  end

  def customers_with_pending_invoices
    pending_invoices.map do |invoice|
      invoice.customer
    end
  end

  def quantity
    successful_invoices.inject(0) {|sum, invoice| sum + invoice.quantity}
  end

end
