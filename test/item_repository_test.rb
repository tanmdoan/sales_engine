require './test/test_helper'

class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repository

  def setup
    @item_repository = ItemRepository.load('./data/fixtures/items_sample.csv')
  end

  def test_that_item_repository_contains_transaction_data
    assert_equal 10, item_repository.items.count
  end

  def test_to_verify_that_transaction_repository_is_not_empty
    refute item_repository.items.empty?
  end

end
