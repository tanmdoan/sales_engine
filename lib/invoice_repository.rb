require 'csv'
require_relative 'invoice'

class InvoiceRepository
  attr_reader :invoices

  def initialize(invoices)
    @invoices = invoices
  end

  def self.load(sales_engine, file ='./data/fixtures/invoices_sample.csv')
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Invoice.new(row, sales_engine)
    end
    new(rows)
  end

  def find_by_id(id)
    results = invoices.detect do |invoice|
      invoice.id == id
    end
  end

  def find_by_customer_id(customer_id)
    invoices.detect do |invoice|
    invoice.customer_id == customer_id
    end
  end

  def find_all_by_customer_id(customer_id)
    invoices.select do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_by_merchant_id(merchant_id)
    invoices.detect do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.select do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_by_status(status)
    invoices.detect do |invoice|
      invoice.status == status
    end
  end

  def find_all_by_status(status)
    invoices.select do |invoice|
      invoice.status == status
    end
  end

  def random
    invoices.sample
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

end
