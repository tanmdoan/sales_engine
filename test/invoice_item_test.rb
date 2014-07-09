require './test/test_helper'

class InvoiceItemTest<Minitest::Test
    attr_reader :invoice_item
  def setup
    @invoice_item = InvoiceItem.new(data, sales_engine = nil)
  end

  def data
    {
      id: "1",
      item_id: "2",
      invoice_id: "3",
      quantity: "100",
      unit_price: "12345",
      created_at: "2014-06-14 12:12:12 UTC",
      updated_at: "2014-06-30 14:15:05 UTC"
    }
  end

  def test_it_has_an_id
    assert_equal 1, invoice_item.id
  end
  def test_it_has_an_item_id
    assert_equal 2, invoice_item.item_id
  end
  def test_it_has_an_invoice_id
    assert_equal 3, invoice_item.invoice_id
  end

  def test_it_has_a_quantity
    assert_equal 100, invoice_item.quantity
  end

  def test_it_has_a_unit_price
    assert_equal BigDecimal.new("12345.00"), invoice_item.unit_price
  end

  def test_it_is_created_at
    assert_equal "2014-06-14 12:12:12 UTC", invoice_item.created_at
  end

  def test_it_is_updated_at
    assert_equal "2014-06-30 14:15:05 UTC", invoice_item.updated_at
  end
end
