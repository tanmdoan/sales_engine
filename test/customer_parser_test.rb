require './test/test_helper'


class CustomerParserTest < Minitest::Test
  attr_reader :customer_parser

  def setup
    @customer_parser = CustomerParser.load('./data/fixtures/customers_sample.csv').parse
  end

  def test_that_customer_parser_contains_customer_data
    assert 10 <= customer_parser.count
  end

  def test_to_verify_that_customer_parser_is_not_empty
    refute customer_parser.empty?
  end


end
