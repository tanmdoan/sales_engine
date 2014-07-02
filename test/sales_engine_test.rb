require './test/test_helper'


class SalesEngineTest < Minitest::Test
  attr_reader :engine

  def setup
    @engine = SalesEngine.new
    @engine.startup
  end

  def test_customer_repository_exist_on_engine_start_up
    # engine = SalesEngine.new
    # engine.startup
    assert_equal 1000, engine.customer_repository.customers.count
    assert_equal "Joey", engine.customer_repository.customers.first.first_name
  end
end
