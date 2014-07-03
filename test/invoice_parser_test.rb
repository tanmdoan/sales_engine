require './test/test_helper'


class InvoiceParserTest < Minitest::Test
  attr_reader :invoice_parser

  def setup
    @customer_parser = InvoiceParse.load('./data/fixtures/customers_sample.csv').parse
  end

  def test_that_customer_parser_contains_invoice_data
    assert 10 <= invoice_parser.count
  end

  def test_to_verify_that_invoice_parser_is_not_empty
    refute invoice_parser.empty?
  end


end
