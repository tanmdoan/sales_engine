require './test/test_helper'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :invoice_item_repository

  def setup
    @invoice_item_repository = InvoiceItemRepository.load('./data/fixtures/invoice_items_sample.csv')
  end

  def test_that_invoice_item_repository_contains_invoice_item_data
    assert_equal 10, invoice_item_repository.invoice_items.count
  end

  def test_to_verify_that_invoice_item_repository_is_not_empty
    refute invoice_item_repository.invoice_items.empty?
  end

  def test_it_can_find_by_id
    results = invoice_item_repository.find_by_id(3)
    assert_equal 1, results.count
    results.each do |invoice_item|
      assert_equal "3", invoice_item.id
    end
  end

  def test_it_can_find_by_item_id
    results = invoice_item_repository.find_by_item_id(539)
    assert_equal 1, results.count
    results.each do |invoice_item|
      assert_equal "539", invoice_item.item_id
    end
  end

  def test_it_can_find_by_invoice_id
    results = invoice_item_repository.find_by_invoice_id(1)
    assert_equal 1, results.count
    results.each do |invoice_item|
      assert_equal "1", invoice_item.invoice_id
    end
  end

  def test_it_can_find_all_invoice_ids
    results = invoice_item_repository.find_all_by_invoice_id(1)
    assert_equal 8, results.count
    results.each do |invoice_item|
      assert_equal "1", invoice_item.invoice_id
    end
  end

  def test_it_can_find_by_a_quantity
    results = invoice_item_repository.find_by_quantity(5)
    assert_equal 1, results.count
    results.each do |invoice_item|
      assert_equal "5", invoice_item.quantity
    end
  end

  def test_it_can_find_all_quantity
    results = invoice_item_repository.find_all_by_quantity(5)
    assert_equal 2, results.count
    results.each do |invoice_item|
      assert_equal "5", invoice_item.quantity
    end
  end

  def test_it_can_find_by_a_unit_price
    results = invoice_item_repository.find_by_unit_price(23324)
    assert_equal 1, results.count
    results.each do |invoice_item|
      assert_equal "23324", invoice_item.unit_price
    end
  end

  def test_it_can_find_all_by_unit_price
    results = invoice_item_repository.find_all_by_unit_price(23324)
    assert_equal 1, results.count
    results.each do |invoice_item|
      assert_equal "23324", invoice_item.unit_price
    end
  end

  def test_it_can_find_all_instances_of_invoice_items
    results = invoice_item_repository.invoice_items.count
    assert 10 <= results
  end

  def test_it_can_pull_a_random_invoice_items_instance
    results = invoice_item_repository.random
    assert_equal 1, results.count
  end
end
