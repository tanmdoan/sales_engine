require './test/test_helper'

class MerchantTest<Minitest::Test
  def data
    {
      id: "1",
      name: "Turing",
      created_at: "2014-06-14 12:12:12 UTC",
      updated_at: "2014-06-30 14:15:05 UTC"
    }
  end

  def test_it_has_a_id
    merchant = Merchant.new(data, sales_engine=nil)
    assert_equal "1", merchant.id
  end

  def test_it_has_a_name
    merchant = Merchant.new(data, sales_engine=nil)
    assert_equal "Turing", merchant.name
  end

  def test_it_is_created_at
    merchant = Merchant.new(data, sales_engine=nil)
    assert_equal "2014-06-14 12:12:12 UTC", merchant.created_at
  end

  def test_it_is_updated_at
    merchant = Merchant.new(data, sales_engine=nil)
    assert_equal "2014-06-30 14:15:05 UTC", merchant.updated_at
  end

end
