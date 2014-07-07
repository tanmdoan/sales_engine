require './test/test_helper'
require 'bigdecimal'

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

  def test_sales_engine_can_find_all_transactions_associated_with_an_invoice
    invoice = engine.invoice_repository.find_by_id(1002)
    invoice_id = invoice.id
    transactions = engine.transaction_repository.find_by_invoice_id(invoice_id)
    assert_equal 1, invoice.transactions.count
  end

  def test_sales_engine_can_find_all_invoice_items_associated_with_an_invoice
    invoice = engine.invoice_repository.find_by_id(1002)
    invoice_id = invoice.id
    invoice_items = engine.invoice_item_repository.find_by_invoice_id(invoice_id)
    assert_equal 3, invoice.invoice_items.count
    item = invoice.invoice_items.find {|ii| ii.item.name == 'Item Accusamus Officia' }

  end

  def test_sales_engine_can_find_all_items_associated_with_an_invoice
    invoice = engine.invoice_repository.find_by_id(1002)
    invoice_id = invoice.id
    invoice_items = engine.invoice_item_repository.find_by_invoice_id(invoice_id)
    assert_equal 3, invoice.items.count
    item = invoice.items.find {|i| i.name == 'Item Accusamus Officia' }
    assert_equal 'Item Accusamus Officia', item.name
  end

  def test_sales_engine_can_find_customer_associated_with_an_invoice
    invoice = engine.invoice_repository.find_by_id(1002)
    customer_id = invoice.customer_id
    customer = engine.customer_repository.find_by_id(customer_id)
    assert_equal "Eric", customer.first_name
  end

  def test_sales_engine_can_find_merchants_associated_with_an_invoice
    invoice = engine.invoice_repository.find_by_id(1002)
    merchant_id = invoice.merchant_id
    merchant = engine.merchant_repository.find_by_id(merchant_id)
    assert_equal "Rogahn LLC", merchant.name
  end

  def test_sales_engine_can_find_invoices_associated_with_an_invoice_item
    invoice_item = engine.invoice_item_repository.find_by_id(16934)
    invoice_id = invoice_item.invoice_id
    invoice = engine.invoice_repository.find_by_id(invoice_id)
    assert_equal "shipped", invoice.status
  end

  def test_sales_engine_can_find_items_associated_with_an_invoice_item
    invoice_item = engine.invoice_item_repository.find_by_id(16934)
    item_id = invoice_item.item_id
    item = engine.item_repository.find_by_id(item_id)
    assert_equal "Item Cupiditate Magni", item.name
  end

  def test_sales_engine_can_find_invoice_items_associated_with_item
    item = engine.item_repository.find_by_name("Item Saepe Ipsum")
    assert_equal 8, item.invoice_items.count
  end

  def test_sales_engine_can_find_merchant_associated_with_item
    item = engine.item_repository.find_by_name("Item Saepe Ipsum")
    assert_equal "Kilback Inc", item.merchant.name
  end

  def test_sales_engine_can_find_invoices_associated_with_customer
    customer = engine.customer_repository.find_by_id(999)
    assert_equal 7, customer.invoices.count
  end

  def test_sales_engine_can_find_invoice_customer_associated_with_transactions
    skip
    transaction = engine.transaction_repository.find_by_id(1138)
    invoice_id   = transaction.invoice_id
    invoice     = engine.invoice_repository.find_by_id(invoice_id)
    customer_id  = invoice.customer_id
    customer     = engine.customer_repository.find_by_id(customer_id)
    assert_equal "Chloe", transaction.invoice.customer.first_name
  end

  def test_sales_engine_can_rank_merchants_by_revenue
    most = engine.merchant_repository.most_revenue(3)
    assert_equal "Dicki-Bednar", engine.merchant_repository.most_revenue.first.name
    assert_equal "Okuneva, Prohaska and Rolfson", engine.merchant_repository.most_revenue.last.name
  end

  def test_sales_engine_can_rank_merchants_by_most_items
    most = engine.merchant_repository.most_items(5)
    assert_equal "Kassulke, O'Hara and Quitzon", engine.merchant_repository.most_revenue.first.name
    assert_equal "Daugherty Group", engine.merchant_repository.most_revenue.last.name

  def test_it_can_return_revenue_for_a_specific_date
    date = "Tue, 20 Mar 2012"
    revenue = engine.merchant_repository.revenue(date)
    assert_equal BigDecimal.new("2549722.91"), revenue
  end

end
