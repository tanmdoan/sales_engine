require 'csv'
require_relative 'transaction'

class TransactionRepository
  attr_reader :transactions, :sales_engine

  def initialize(transactions)
    @transactions = transactions
  end

  def self.load(sales_engine, file='./data/customers.csv')
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Transaction.new(row, sales_engine)
    end
    new(rows)
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


  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
