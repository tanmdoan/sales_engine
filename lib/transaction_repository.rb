require 'csv'
require_relative 'transaction'

class TransactionRepository
  attr_reader :transactions, :sales_engine

  def initialize(transactions, sales_engine)
    @transactions = transactions
    @sales_engine = sales_engine
  end

  def self.load(sales_engine, file='./data/customers.csv')
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Transaction.new(row, sales_engine)
    end
    new(rows, sales_engine)
  end

  def find_by_id(id)
    transactions.detect do |transaction|
      transaction.id == id
    end
  end

  def find_by_invoice_id(invoice_id)
    transactions.detect do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    transactions.select do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_by_credit_card_number(credit_card_number)
    transactions.detect do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    transactions.select do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_by_result(result)
    transactions.detect do |transaction|
      transaction.result == result
    end
  end

  def find_all_by_result(result)
    transactions.select do |transaction|
      transaction.result == result
    end
  end

  def random
    transactions.sample
  end

  def all
    @transactions
  end

  def create(transaction_data)
    time_now = Time.now.to_s
    transaction_data[:id]         = all.last.id + 1
    transaction_data[:created_at] = time_now
    transaction_data[:updated_at] = time_now
    all << Transaction.new(transaction_data, sales_engine)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
end
