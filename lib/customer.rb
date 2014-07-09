class Customer
  attr_reader :id, :first_name, :last_name,
              :created_at, :updated_at, :sales_engine

  def initialize(data, sales_engine)
    @id         = data[:id].to_i
    @first_name = data[:first_name]
    @last_name  = data[:last_name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @sales_engine = sales_engine
  end

  def invoices
    sales_engine.invoice_repository.find_all_by_customer_id(id)
  end

  def transactions
    invoices.map {|invoice| invoice.transactions}.flatten
  end

  def successful_invoices
    invoices.select(&:successful?)
  end

  def favorite_merchant
    successful_invoices.group_by {|invoice|
      invoice.merchant_id}.max_by {|merchant| merchant[1].count}[-1][0].merchant
    end
  end
