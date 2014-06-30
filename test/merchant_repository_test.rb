require './test/test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repository

  def setup
    @merchant_repository = MerchantRepository.load('./data/fixtures/merchants_sample.csv')
  end

  def test_that_merchant_repository_contains_merchant_data
    assert_equal 10, merchant_repository.merchants.count
  end

  def test_to_verify_that_merchant_repository_is_not_empty
    refute merchant_repository.merchants.empty?
  end

end
