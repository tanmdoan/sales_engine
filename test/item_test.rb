require './test/test_helper'

class ItemTest<Minitest::Test
  attr_reader :item, :sales_engine

  def setup
    @item = Item.new(data, sales_engine)
  end

  def data
    {
      id: "1",
      name: "Turing",
      description: "Widgit",
      unit_price: "23458",
      merchant_id: "2",
      created_at: "2014-06-14 12:12:12 UTC",
      updated_at: "2014-06-30 14:15:05 UTC"
    }
  end

  def test_it_has_a_id
    assert_equal 1, item.id
  end

  def test_it_has_a_name
    assert_equal "Turing", item.name
  end

  def test_it_has_description
    assert_equal "Widgit", item.description
  end

  def test_it_has_a_unit_price
    assert_equal BigDecimal.new("23458"), item.unit_price
  end

  def test_it_has_a_merchant_id
    assert_equal 2, item.merchant_id
  end

  def test_it_is_created_at
    assert_equal "2014-06-14 12:12:12 UTC", item.created_at
  end

  def test_it_is_updated_at
    assert_equal "2014-06-30 14:15:05 UTC", item.updated_at
  end
end
