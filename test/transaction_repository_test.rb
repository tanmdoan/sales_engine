require './test/test_helper'

class TransactionRepositoryTest < Minitest::Test
  attr_reader :transaction_repository

  def setup
    @transaction_repository = TransactionRepository.load('./data/fixtures/transactions_sample.csv')
  end

  def test_that_transaction_repository_contains_transaction_data
    assert_equal 10, transaction_repository.transactions.count
  end

  def test_to_verify_that_transaction_repository_is_not_empty
    refute transaction_repository.transactions.empty?
  end

end
