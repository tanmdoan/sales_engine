require './test/test_helper'

class TransactionRepositoryTest < Minitest::Test
  attr_reader :transaction_repository

  def setup
    @transaction_repository = TransactionRepository.load(self, './data/fixtures/transactions_sample.csv')
  end

  def test_that_transaction_repository_contains_transaction_data
    # skip
    assert_equal 10, transaction_repository.transactions.count
  end

  def test_to_verify_that_transaction_repository_is_not_empty
    # skip
    refute transaction_repository.transactions.empty?
  end

  def test_it_can_find_by_transaction_id
    # skip
    results = transaction_repository.find_by_id(3)
    assert_equal 1, results.count
    results.each do |transaction|
      assert_equal "3", transaction.id
    end
  end

  def test_it_can_find_by_invoice_id
    # skip
    results = transaction_repository.find_by_invoice_id(1)
    assert_equal 1, results.count
    results.each do |transaction|
      assert_equal "1", transaction.invoice_id
    end
  end

  def test_it_can_find_by_credit_card_number
    # skip
    results = transaction_repository.find_by_credit_card_number(4654405418249632)
    assert_equal 1, results.count
    results.each do |transaction|
      assert_equal "4654405418249632", transaction.credit_card_number
    end
  end

  def test_it_can_find_all_by_credit_card_number
    # skip
    results = transaction_repository.find_all_by_credit_card_number(4654405418249632)
    assert_equal 1, results.count
    results.each do |transaction|
      assert_equal "4654405418249632", transaction.credit_card_number
    end
  end

  def test_it_can_find_by_result
    # skip
    results = transaction_repository.find_by_result("success")
    assert_equal 1, results.count
    results.each do |transaction|
      assert_equal "success", transaction.result
    end
  end

  def test_it_can_find_all_by_result
    # skip
    results = transaction_repository.find_all_by_result("success")
    assert_equal 9, results.count
    results.each do |transaction|
      assert_equal "success", transaction.result
    end
  end

  def test_it_can_find_all_instances_of_transactions
    # skip
    results = transaction_repository.transactions.count
    assert 10 <= results
  end

  def test_it_can_pull_a_random_transaction_instance
    # skip
    results = transaction_repository.random
    assert_equal 1, results.count
  end
end
