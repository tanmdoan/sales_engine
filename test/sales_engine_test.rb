require 'pry'
require './test/test_helper'
require 'bigdecimal'


class SalesEngineTest < Minitest::Test

  attr_reader :engine, :invoice_repository, :item_repository, :customer_repository, :merchant_repository,
  :invoice_items

  def setup
    @engine = SalesEngine.new
    engine.startup
  end

  def test_customer_repository_exist_on_engine_start_up
    assert_equal 1000, engine.customer_repository.customers.count
    assert_equal "Joey", engine.customer_repository.customers.first.first_name
  end

  def test_sales_engine_can_find_by_all_items_sold_by_a_merchant
    merchant   = engine.merchant_repository.find_by_name("Kirlin, Jakubowski and Smitham")
    assert_equal 33, merchant.items.count
    item = merchant.items.find {|i| i.name == 'Item Consequatur Odit' }
    assert_equal 'Item Consequatur Odit', item.name
  end

  def test_sales_engine_can_find_all_invoices_associated_with_a_merchant
    merchant    = engine.merchant_repository.find_by_name("Kirlin, Jakubowski and Smitham")
    assert_equal 43, merchant.invoices.count
  end

  def test_sales_engine_can_find_all_transactions_associated_with_an_invoice
    invoice = engine.invoice_repository.find_by_id(1002)
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
    transaction = engine.transaction_repository.find_by_id(1138)
    assert_equal "Chloe", transaction.invoice.customer.first_name
  end

  def test_it_reports_all_revenue_for_a_merchant
    merchant = engine.merchant_repository.find_by_name("Dicki-Bednar")
    assert_equal BigDecimal.new("1148393.74"), merchant.revenue
  end

  def test_it_reports_all_revenue_by_date_for_a_merchant
    merchant = engine.merchant_repository.find_by_name("Willms and Sons")
    date     = Date.parse "Fri, 09 Mar 2012"
    assert_equal BigDecimal.new("8373.29"), merchant.revenue(date)
  end

  def test_it_can_return_an_array_of_transaction_instances_associated_with_a_customer
    customer = engine.customer_repository.find_by_id(2)
    assert_equal 1, customer.transactions.count
  end

  def test_it_can_return_an_instance_of_merchant_where_customer_has_the_most_transactions
    customer = engine.customer_repository.find_by_id(2)
    assert_equal "Shields, Hirthe and Smith", customer.favorite_merchant.name
  end

  def test_it_can_return_an_instance_of_customer_with_the_most_merchant_transactions
    merchant = engine.merchant_repository.find_by_name("Terry-Moore")
    assert_equal "Hammes", merchant.favorite_customer.last_name
  end

  def test_it_can_give_a_collection_of_successful_transactions
    customer = engine.customer_repository.find_by_id(1)
    assert_equal 7, customer.successful_invoices.count
  end

  def test_it_can_find_a_collection_of_customers_with_pending_invoices
    merchant = engine.merchant_repository.find_by_name "Parisian Group"
    customers = merchant.customers_with_pending_invoices
    assert customers.any? do |customer|
      customer.last_name == "Ledner"
    end
    assert_equal 4, customers.count
  end

  def test_it_can_rank_the_top_merchants_by_total_revenue
     most = engine.merchant_repository.most_revenue(3)
     assert_equal "Dicki-Bednar", most.first.name
     assert_equal "Okuneva, Prohaska and Rolfson", most.last.name
  end

  def test_it_can_rank_the_top_merchants_by_total_number_of_items
    most = engine.merchant_repository.most_items(5)
    assert_equal "Kassulke, O'Hara and Quitzon", most.first.name
    assert_equal "Daugherty Group", most.last.name
  end

  def test_it_returns_total_revenue_for_all_merchants_given_a_date
    date = Date.parse "Tue, 20 Mar 2012"
    revenue = engine.merchant_repository.revenue(date)
    assert_equal BigDecimal.new("2549722.91"), revenue
  end

  def test_it_reports_most_revenue_by_item
    most = engine.item_repository.most_revenue(5)
    assert_equal 5, most.size
    assert_equal "Item Dicta Autem",    most.first.name
    assert_equal "Item Amet Accusamus", most.last.name
  end

  def test_it_reports_most_items_sold
    most = engine.item_repository.most_items(37)
    assert_equal 37, most.size
    assert_equal "Item Nam Magnam", most[1].name
    assert_equal "Item Ut Quaerat", most.last.name
  end

  def test_it_returns_the_date_with_the_most_sales_for_the_given_item_using_the_invoice_date
    item = engine.item_repository.find_by_name "Item Accusamus Ut"
    assert_equal Date.new(2012, 3, 24), item.best_day.to_date
  end

  def test_it_can_create_a_new_invoice
    customer = engine.customer_repository.find_by_id(7)
    merchant = engine.merchant_repository.find_by_id(22)
    items    = (1..3).map{engine.item_repository.random}

    invoice_count      = engine.invoice_repository.invoices.count
    invoice_item_count = engine.invoice_item_repository.invoice_items.count
    assert invoice_count + 1 <= invoice_item_count,
      engine.invoice_repository.create(customer: customer, merchant: merchant, items: items)
  end

end
