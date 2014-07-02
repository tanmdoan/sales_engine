require './test/test_helper'

class InvoiceRepository
  attr_reader :invoices

  def initialize(invoices)
    @invoices = invoices
  end

  def self.load(file ='./data/invoices.csv')
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Invoice.new(row)
    end
    new(rows)
  end

  def find_by_id(id)
    id = id.to_s
    results = invoices.select do |invoice|
      invoice.id == id
    end
  end

  def find_by_customer_id(customer_id)
    customer_id = customer_id.to_s
    selected = []
    invoices.detect do |invoice|
      selected << invoice if invoice.customer_id == customer_id
    end
    selected
  end

  def find_by_all_customer_id(customer_id)
    customer_id = customer_id.to_s
    invoices.select do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_by_merchant_id(merchant_id)
    merchant_id = merchant_id.to_s
    selected = []
    invoices.detect do |invoice|
      selected << invoice if invoice.merchant_id == merchant_id
    end
    selected
  end

  def find_by_status(status)
    status = status.to_s
    invoices.select do |invoice|
      invoice.status == status
    end
  end

  def random
    selected = []
    selected << invoices.sample
    selected
  end
end
