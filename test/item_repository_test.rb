require './test/test_helper'

class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repository

  def setup
    @item_repository ||= ItemRepository.load(self, './data/fixtures/items_sample.csv')
  end

  def test_that_item_repository_contains_transaction_data
    assert 10 <= item_repository.items.count
  end

  def test_to_verify_that_item_repository_is_not_empty
    refute item_repository.items.empty?
  end

  def test_it_can_find_by_item_id
    results = item_repository.find_by_id(3)
    assert_equal "3", results.id
  end

  def test_it_can_find_by_item_name
    results = item_repository.find_by_name("Item Qui Esse")
    assert_equal "Item Qui Esse", results.name
  end

  def test_it_can_find_by_item_by_merchant_id
    results = item_repository.find_by_merchant_id(1)
    assert_equal 1, results.count
    results.each do |item|
      assert_equal "1", item.merchant_id
    end
  end

  def test_it_can_find_all_by_merchant_id
    results = item_repository.find_all_by_merchant_id("1")
    assert_equal 10, results.count
    results.each do |item|
      assert_equal "1", item.merchant_id
    end
  end

  def test_it_can_find_by_item_by_unit_price
    results = item_repository.find_by_unit_price(75107)
    assert_equal 1, results.count
    results.each do |item|
      assert_equal "75107", item.unit_price
    end
  end

  def test_it_can_find_all_by_unit_price
    results = item_repository.find_all_by_unit_price("75107")
    assert_equal 1, results.count
    results.each do |item|
      assert_equal "75107", item.unit_price
    end
  end

  def test_it_can_pull_a_random_items_instance
    results = item_repository.random
    assert_equal 1, results.count
  end

  def test_it_can_find_all_instances_of_items
    item_repository = ItemRepository.load(self, './data/items.csv')
    assert 100 <= item_repository.items.count
  end

end
