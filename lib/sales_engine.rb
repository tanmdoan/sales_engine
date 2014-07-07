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
    startup
  end


  def startup

    @item_repository ||= ItemRepository.load(self)
    @merchant_repository ||= MerchantRepository.load(self)
    @transaction_repository ||= TransactionRepository.load(self)
    @invoice_repository ||= InvoiceRepository.load(self)
    @invoice_item_repository ||= InvoiceItemRepository.load(self)
    @customer_repository ||= CustomerRepository.load(self)
  end
end
