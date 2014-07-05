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
    # items = ItemParser.load(self)
    # transactions = TransactionParser.load.parse
    # invoices = InvoiceParser.load.parse
    # # invoice_items = InvoiceItemParser.load.parse
    # merchants = MerchantParser.load.parse
    # customers = CustomerParser.load.parse


    @item_repository ||= ItemRepository.load(self)
    @merchant_repository ||= MerchantRepository.load(self)
    @transaction_repository ||= TransactionRepository.load(self)
    @invoice_repository ||= InvoiceRepository.load(self)
    @invoice_item_repository ||= InvoiceItemRepository.load(self)
    @customer_repository ||= CustomerRepository.load(self)
  end
# binding.pry
end
