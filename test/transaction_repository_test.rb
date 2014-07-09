require './test/test_helper'

class TransactionRepositoryTest < Minitest::Test
  attr_reader :transaction_repository

  def setup
    @transaction_repository ||= TransactionRepository.load(self, './data/fixtures/transactions_sample.csv')
  end

  def test_that_transaction_repository_contains_transaction_data
    assert_equal 10, transaction_repository.transactions.count
  end

  def test_to_verify_that_transaction_repository_is_not_empty
    refute transaction_repository.transactions.empty?
  end

  def test_it_can_find_by_transaction_id
    results = transaction_repository.find_by_id(3)
    assert_equal 3, results.id
  end

  def test_it_can_find_by_invoice_id
    results = transaction_repository.find_by_invoice_id(1)
    assert_equal 1, results.invoice_id
  end

  def test_it_can_find_by_credit_card_number
    results = transaction_repository.find_by_credit_card_number('4654405418249632')
    assert_equal "4654405418249632", results.credit_card_number
  end

  def test_it_can_find_all_by_credit_card_number
    results = transaction_repository.find_all_by_credit_card_number('4654405418249632')
    assert_equal '4654405418249632', results.first.credit_card_number
  end

  def test_it_can_find_by_result
    results = transaction_repository.find_by_result("success")
    assert_equal "success", results.result
  end

  def test_it_can_find_all_by_result
    results = transaction_repository.find_all_by_result("success")
    assert_equal 9, results.count
    results.each do |transaction|
      assert_equal "success", transaction.result
    end
  end

  def test_it_can_find_all_instances_of_transactions
    results = transaction_repository.transactions.count
    assert 10 <= results
  end

  def test_it_can_pull_a_random_transaction_instance
    transaction_one = transaction_repository.random
    transaction_two = transaction_repository.random

    10.times do
      break if transaction_one.id != transaction_two.id
      transaction_two = transaction_repository.random
    end

    refute transaction_one.id == transaction_two.id
  end
end
