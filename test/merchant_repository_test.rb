require './test/test_helper'
require 'bigdecimal'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repository

  def setup
    @merchant_repository ||= MerchantRepository.load(self,'./data/fixtures/merchants_sample.csv')
  end

  def test_that_merchant_repository_contains_merchant_data
    assert 10 <= merchant_repository.merchants.count
  end

  def test_to_verify_that_merchant_repository_is_not_empty
    refute merchant_repository.merchants.empty?
  end

  def test_it_can_find_by_merchant_id
    results = merchant_repository.find_by_id(3)
    assert_equal 3, results.id
  end

  def test_it_can_find_by_merchant_name

    results = merchant_repository.find_by_name("Williamson Group")
    assert_equal "Williamson Group", results.name
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
    merchant_one = merchant_repository.random
    merchant_two = merchant_repository.random

    10.times do
      break if merchant_one.id != merchant_two.id
      merchant_two = merchant_repository.random
    end

    refute merchant_one.id == merchant_two.id 
  end


end
