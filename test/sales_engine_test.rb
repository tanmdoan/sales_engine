require './test/test_helper'
require 'pry'

class SalesEngineTest < Minitest::Test
  attr_reader :engine, :invoice_repository, :item_repository, :customer_repository, :merchant_repository

  def setup
    # @invoice_repository ||= InvoiceRepository.load(self, './data/fixtures/invoices_sample.csv')
    # @item_repository ||= ItemRepository.load(self, './data/fixtures/items_sample.csv')
    # @customer_repository ||= CustomerRepository.load(self, './data/fixtures/customers_sample.csv')
    # @merchant_repository ||= MerchantRepository.load(self, './data/fixtures/merchants_sample.csv')

    @engine = SalesEngine.new
    @engine.startup
  end

  def test_customer_repository_exist_on_engine_start_up

    # engine = SalesEngine.new
    # engine.startup
    assert_equal 1000, engine.customer_repository.customers.count
    assert_equal "Joey", engine.customer_repository.customers.first.first_name
  end

  def test_sales_engine_can_find_by_all_items_sold_by_a_merchant
    merchant   = engine.merchant_repository.find_by_name("Kirlin, Jakubowski and Smitham")
    merchant_id = merchant.id
    items       = engine.item_repository.find_by_merchant_id(merchant_id)
    assert_equal 33, merchant.items.count
    item = merchant.items.find {|i| i.name == 'Item Consequatur Odit' }
    assert_equal 'Item Consequatur Odit', item.name
  end

  def test_sales_engine_can_find_all_invoices_associated_with_a_merchant
    merchant    = engine.merchant_repository.find_by_name("Kirlin, Jakubowski and Smitham")
    merchant_id = merchant.id
    invoices    = engine.invoice_repository.find_by_merchant_id(merchant_id)
    assert_equal 43, merchant.invoices.count
  end


end
