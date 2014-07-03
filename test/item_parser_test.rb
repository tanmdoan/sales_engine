require './test/test_helper'


class ItemParserTest < Minitest::Test
  attr_reader :item_parser

  def setup
    @item_parser = ItemParser.load('./data/fixtures/items_sample.csv').parse
  end

  def test_that_merchant_parser_contains_merchant_data
    assert 10 <= item_parser.count
  end

  def test_to_verify_that_merchant_parser_is_not_empty
    refute item_parser.empty?
  end


end
