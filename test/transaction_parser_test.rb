# require './test/test_helper'
#
#
# class TransactionParserTest < Minitest::Test
#   attr_reader :transaction_parser
#
#   def setup
#     @transaction_parser = TransactionParser.load('./data/fixtures/transactions_sample.csv').parse
#   end
#
#   def test_that_merchant_parser_contains_merchant_data
#     assert 10 <= transaction_parser.count
#   end
#
#   def test_to_verify_that_merchant_parser_is_not_empty
#     refute transaction_parser.empty?
#   end
#
#
# end
