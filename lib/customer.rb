class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at, :sales_engine

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

  def merchant_tally
  end

  def favorite_merchant
    grouped_merchants = successful_invoices.group_by do |invoice|
      invoice.merchant_id
    end

    grouped_merchants.max_by {|merchant| merchant.count}[-1][0].merchant







    # merchants = transactions.map {|t| t.merchant if t.result == 'success'}
    # merchants.group_by {|i| item}.values.values.max_by(&:size).first
    # successful_transactions = transactions.select {|transaction|
      # transaction.result == 'success'}

    # successful_transactions.group_by {|item| item} #.values.max_by(&:size).first
    # invoice_transactions = successful_transactions.map {|transaction|
    #   transaction.invoice}
    #
    # best_merchant = invoice_transactions.map {|invoice| invoice.merchant}.first
  end

end
