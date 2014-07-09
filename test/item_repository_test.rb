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
    assert_equal 3, results.id
  end

  def test_it_can_find_by_item_name
    results = item_repository.find_by_name("Item Qui Esse")
    assert_equal "Item Qui Esse", results.name
  end

  def test_it_can_find_by_merchant_id
    results = item_repository.find_by_merchant_id(1)
    assert_equal 1, results.merchant_id
  end

  def test_it_can_find_all_by_merchant_id
    results = item_repository.find_all_by_merchant_id(1)
    assert_equal "Item Qui Esse", results.first.name
  end

  def test_it_can_pull_a_random_items_instance
    item_one = item_repository.random
    item_two = item_repository.random

    10.times do
      break if item_one.id != item_two.id
      item_two = item_repository.random
    end

    refute item_one.id == item_two.id
  end

  def test_it_can_find_all_instances_of_items
    item_repository = ItemRepository.load(self, './data/items.csv')
    assert 100 <= item_repository.items.count
  end

end
