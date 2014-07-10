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
              :invoice_repository, :dir
  def initialize(dir = "./data")
    @dir = dir
  end

  def startup
    @item_repository ||=
      ItemRepository.load(self, "#{dir}/items.csv")
    @merchant_repository ||=
      MerchantRepository.load(self, "#{dir}/merchants.csv")
    @transaction_repository ||=
      TransactionRepository.load(self, "#{dir}/transactions.csv")
    @invoice_repository ||=
      InvoiceRepository.load(self, "#{dir}/invoices.csv")
    @invoice_item_repository ||=
      InvoiceItemRepository.load(self, "#{dir}/invoice_items.csv")
    @customer_repository ||=
      CustomerRepository.load(self, "#{dir}/customers.csv")
  end

end
