require './test/test_helper'

class CustomerTest<Minitest::Test

  def setup
    # @customer = Customer.new(data)
  end

  def data
    {
      id: "1",
      first_name: "John Bob",
      created_at: "2014-06-14 12:12:12 UTC",
      updated_at: "2014-06-30 14:15:05 UTC"
    }
  end

  def test_it_has_a_id
    customer = Customer.new(data)
    assert_equal "1", customer.id
  end

  def test_it_has_a_first_name
    customer = Customer.new(data)
    assert_equal "John Bob", customer.first_name
  end

  def test_it_is_created_at
    customer = Customer.new(data)
    assert_equal "2014-06-14 12:12:12 UTC", customer.created_at
  end

  def test_it_is_updated_at
    customer = Customer.new(data)
    assert_equal "2014-06-30 14:15:05 UTC", customer.updated_at
  end
end
