require_relative 'item_repository'
require_relative 'transaction_repository'
require_relative 'invoice_repository'
require_relative 'merchant_repository'
require_relative 'customer_repository'
require_relative 'invoice_item_repository'

class SalesEngine
  attr_reader :item_repository, :transaction_repository,
              :invoice_item_repository,
              :customer_repository, :merchant_repository,
              :invoice_repository
  def initialize(dir = nil)
  end


  def startup

    @item_repository ||= ItemRepository.load(self, './data/items.csv')
    @merchant_repository ||= MerchantRepository.load(self, './data/merchants.csv')
    @transaction_repository ||= TransactionRepository.load(self, './data/transactions.csv')
    @invoice_repository ||= InvoiceRepository.load(self, './data/invoices.csv')
    @invoice_item_repository ||= InvoiceItemRepository.load(self, './data/invoice_items.csv')
    @customer_repository ||= CustomerRepository.load(self, './data/customers.csv')
  end

  def fixtures_startup
    @invoice_repository ||= InvoiceRepository.load(self, './data/fixtures/invoices_sample.csv')
    @item_repository ||= ItemRepository.load(self, './data/fixtures/items_sample.csv')
    @customer_repository ||= CustomerRepository.load(self, './data/fixtures/customers_sample.csv')
    @merchant_repository ||= MerchantRepository.load(self, './data/fixtures/merchants_sample.csv')
    @invoice_item ||= InvoiceItemRepository.load(self, './data/fixtures/invoice_items_sample.csv')
  end
end
