require './test/test_helper'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :invoice_repository

  def setup
    @invoice_repository = InvoiceRepository.load('./data/fixtures/invoices_sample.csv')
  end

  def test_that_customer_repository_contains_merchant_data
    assert_equal 10, invoice_repository.invoices.count
  end

  def test_to_verify_that_customer_repository_is_not_empty
    refute invoice_repository.invoices.empty?
  end
end
