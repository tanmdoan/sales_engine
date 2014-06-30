require './test/test_helper'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customer_repository

  def setup
    @customer_repository = CustomerRepository.load('./data/fixtures/customers_sample.csv')
  end

  def test_that_customer_repository_contains_merchant_data
    assert_equal 10, customer_repository.customers.count
  end

  def test_to_verify_that_customer_repository_is_not_empty
    refute customer_repository.customers.empty?
  end
end
