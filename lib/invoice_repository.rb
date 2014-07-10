require 'csv'
require_relative 'invoice'

class InvoiceRepository
  attr_reader :invoices, :sales_engine

  def initialize(invoices, sales_engine)
    @invoices     = invoices
    @sales_engine = sales_engine
  end

  def self.load(sales_engine, file ='./data/fixtures/invoices_sample.csv')
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Invoice.new(row, sales_engine)
    end
    new(rows, sales_engine)
  end

  def all
    @invoices
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

  def create(data)
    data[:id] = all.last.id + 1
    time      = Time.now.to_s
    invoice = Invoice.new({id: data[:id], customer_id: data[:customer].id,
                          merchant_id: data[:merchant].id, status: data[:status],
                          created_at: time, update_at: time}, sales_engine)
    create_invoice_item(data)
    all << invoice
    invoice
  end

  def create_invoice_item(data)
    sales_engine.invoice_item_repository.create_invoice_items(data)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

end
