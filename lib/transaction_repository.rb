require './test/test_helper'


class TransactionRepository
  attr_reader :transactions

  def initialize(transactions)
    @transactions = transactions
  end

  def self.load(file='./data/transactions.csv')
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Transaction.new(row)
    end
    new(rows)
  end

end
