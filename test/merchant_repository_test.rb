require './test/test_helper'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repository

  def setup
    @merchant_repository = MerchantRepository.load(self,'./data/fixtures/merchants_sample.csv')
  end

  def test_that_merchant_repository_contains_merchant_data
    assert 10 <= merchant_repository.merchants.count
  end

  def test_to_verify_that_merchant_repository_is_not_empty
    refute merchant_repository.merchants.empty?
  end

  def test_it_can_find_by_merchant_id
    skip
    results = merchant_repository.find_by_id(3)
    assert_equal 1, results.count
    results.each do |merchant|
      assert_equal "3", merchant.id
    end
  end

  def test_it_can_find_by_merchant_name
    skip
    results = merchant_repository.find_by_name("Williamson Group")
    assert_equal 1, results
    assert_equal "Williamson Group", merchant.name
  end

  def test_it_can_find_all_merchants_by_name
    results = merchant_repository.find_all_by_name("Williamson Group")
    assert_equal 2, results.count
    results.each do |merchant|
      assert_equal "Williamson Group", merchant.name
    end
  end

  def test_it_can_find_all_instances_of_merchant
    merchant_repo = MerchantRepository.load(self, './data/merchants.csv')
    assert 100 <= merchant_repo.merchants.count
  end

  def test_it_can_pull_a_random_merchant_instance
    results = merchant_repository.random
    assert_equal 1, results.count
  end

end
