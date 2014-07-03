require './test/test_helper'

class SalesEngineTest < Minitest::Test
  attr_reader :engine

  def setup
    @engine = SalesEngine.new
    @engine.startup
  end

  def test_customer_repository_exist_on_engine_start_up
    skip
    # engine = SalesEngine.new
    # engine.startup
    assert_equal 1000, engine.customer_repository.customers.count
    assert_equal "Joey", engine.customer_repository.customers.first.first_name
  end

  def test_sales_engine_can_find_by_all_items_sold_by_a_merchant
    merchant   = engine.merchant_repository.find_by_name("Schroeder-Jerde")
    merchant_id = merchant.id
    items       = engine.item_repository.find_by_merchant_id(merchant_id)
    assert_equal 15, merchant.items.count
  end

  def test_sales_engine_can_find_all_invoices_associated_with_a_merchant
  end
end
