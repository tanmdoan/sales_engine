require './test/test_helper'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :invoice_item_repository

  def setup
    @invoice_item_repository = InvoiceItemRepository.load('./data/fixtures/invoice_items_sample.csv')
  end

  def test_that_customer_repository_contains_merchant_data
    assert_equal 10, invoice_item_repository.invoice_items.count
  end

  def test_to_verify_that_customer_repository_is_not_empty
    refute invoice_item_repository.invoice_items.empty?
  end
end
