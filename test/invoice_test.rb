require './test/test_helper'


class InvoiceTest<Minitest::Test
    attr_reader :invoice

  def setup
    @invoice = Invoice.new(data, self)
  end

  def data
    {
      id: "1",
      customer_id: "2",
      merchant_id: "3",
      status: "shipped",
      unit_price: "12345",
      created_at: "2014-06-14 12:12:12 UTC",
      updated_at: "2014-06-30 14:15:05 UTC"
    }
  end

  def test_it_has_an_id
    assert_equal 1, invoice.id
  end

  def test_it_has_a_customer_id
    assert_equal 2, invoice.customer_id
  end
  def test_it_has_an_invoice_id
    assert_equal 3, invoice.merchant_id
  end

  def test_it_has_a_status
    assert_equal "shipped", invoice.status
  end

  def test_it_is_created_at
    assert_equal "2014-06-14 12:12:12 UTC", invoice.created_at
  end

  def test_it_is_updated_at
    assert_equal "2014-06-30 14:15:05 UTC", invoice.updated_at
  end

end
