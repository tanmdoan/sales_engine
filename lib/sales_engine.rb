require './test/test_helper'
# require 'pry'

class SalesEngine
  attr_reader :item_repository, :transaction_repository,
              :invoice_item_repository,
              :customer_repository, :merchant_repository,
              :invoice_repository
  def initialize(dir = nil)
    startup
  end


  def startup
    # items = ItemParser.load.parse
    # transactions = TransactionParser.load.parse
    # invoices = InvoiceParser.load.parse
    # invoice_items = InvoiceItemParser.load.parse
    merchants = MerchantParser.load.parse
    customers = CustomerParser.load.parse


    # @item_repository ||= ItemRepository.new(items)
    # @transaction_repository ||= TransactionRepository.new(transactions)
    # @invoice_repository ||= InvoiceRepository.new(invoices)
    # @invoice_item_repository ||= InvoiceItemRepository.new(invoice_items)
    @merchant_repository ||= MerchantRepository.new(merchants)
    @customer_repository ||= CustomerRepository.new(customers)
  end
# binding.pry
end