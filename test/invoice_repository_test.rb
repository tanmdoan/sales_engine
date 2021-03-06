require './test/test_helper'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :invoice_repository

  def setup
      @invoice_repository ||= InvoiceRepository.load(self, './data/fixtures/invoices_sample.csv')
  end

  def test_that_invoice_repository_contains_invoice_data
    assert 10 <= invoice_repository.invoices.count
  end

  def test_to_verify_that_invoice_repository_is_not_empty
    refute invoice_repository.invoices.empty?
  end

  def test_it_can_find_by_invoice_id
    results = invoice_repository.find_by_id(3)
    assert_equal 3, results.id
  end

  def test_it_can_find_by_customer_id
    results = invoice_repository.find_by_customer_id(2)
    assert_equal 2, results.customer_id
  end

  def test_it_can_find_by_all_customer_id
    results = invoice_repository.find_all_by_customer_id(1)
    assert_equal 8, results.count
    results.each do |invoice|
      assert_equal 1, invoice.customer_id
    end
  end

  def test_it_can_find_by_merchant_id
    results = invoice_repository.find_by_merchant_id(26)
    assert_equal 26, results.merchant_id
  end

  def test_it_can_find_all_by_status
    results = invoice_repository.find_all_by_status("shipped")
    assert_equal 10, results.count
    results.each do |invoice|
      assert_equal "shipped", invoice.status
    end
  end

  def test_it_can_find_all_instances_of_invoice
    assert_equal 10, invoice_repository.invoices.count
  end

  def test_it_can_pull_a_random_merchant_instance
    invoice_one = invoice_repository.random
    invoice_two = invoice_repository.random

    10.times do
      break if invoice_one.id != invoice_two.id
      invoice_two = invoice_repository.random
    end

    refute invoice_one.id == invoice_two.id

  end
end
