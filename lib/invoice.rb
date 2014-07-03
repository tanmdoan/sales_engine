require './test/test_helper'

class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :repository

  def initialize(data, repository)
    @id          = data[:id]
    @customer_id = data[:customer_id]
    @merchant_id = data[:merchant_id]
    @status      = data[:status]
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @repository  = repository
  end

  def find_by_merchant_id(merchant_id)
    merchant_id = merchant_id.to_s
    selected = []
    repository.detect do |invoice|
      selected << invoice if invoice.merchant_id == merchant_id
    end
  end

  def self
    sales
  end
end
# i = Invoice.new()
# i.find_by_merchant(1)
# i.invoice_repo.find_by_merchant(1)

# invoice_repo.find_by_merchant(1)
