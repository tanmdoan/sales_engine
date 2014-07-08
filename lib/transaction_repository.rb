require 'csv'
require_relative 'transaction'

class TransactionRepository
  attr_reader :transactions, :sales_engine

  def initialize(transactions)
    @transactions = transactions
  end

  def self.load(sales_engine, file='./data/transactions.csv')
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
    credit_card_number = credit_card_number.to_s
    selected = []
    transactions.detect do |transaction|
      selected << transaction if transaction.credit_card_number == credit_card_number
    end
    selected
  end

  def find_all_by_credit_card_number(credit_card_number)
    credit_card_number = credit_card_number.to_s
    transactions.select do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_by_result(result)
    selected = []
    transactions.detect do |transaction|
      selected << transaction if transaction.result == result
    end
    selected
  end

  def find_all_by_result(result)
    transactions.select do |transaction|
      transaction.result == result
    end
  end

  def random
    selected = []
    selected << transactions.sample
    selected
  end

end
