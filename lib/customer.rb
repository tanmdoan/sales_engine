class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at, :sales_engine

  def initialize(data, sales_engine)
    @id         = data[:id]
    @first_name = data[:first_name]
    @last_name  = data[:last_name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @sales_engine = sales_engine
  end

  def invoices
    sales_engine.invoice_repository.find_all_by_customer_id(id)
  end
end
