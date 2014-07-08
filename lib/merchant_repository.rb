require 'csv'
require_relative 'merchant'

class MerchantRepository

   attr_reader :merchants, :sales_engine

   def initialize(merchants)
     @merchants = merchants
   end

   def self.load(sales_engine, file='./data/merchants.csv')
     data = CSV.open(file, headers: true, header_converters: :symbol)
     rows = data.map do |row|
       Merchant.new(row, sales_engine)
     end
     new(rows)
   end

   def find_by_id(id)
     merchants.detect do |merchant|
       merchant.id == id
     end
   end

   def find_by_name(name)
     merchants.detect do |merchant|
       merchant.name == name
     end
   end

   def find_all_by_name(name)
     merchants.select do |merchant|
       merchant.name == name
     end
   end

   def find_by_date(date)
     date = created_at
     merchants.detect do |merchant|
       merchant.created_at == date
     end
   end

   def find_all_by_date(date)
     date = created_at
     merchants.select do |merchant|
       merchant.created_at == date
     end
   end

   def random
     selected = []
     selected << merchants.sample
     selected
   end

   def all_invoices_by_date(date)
     return []
     @merchants.all_successful_invoices.select do |invoice|
       Date.parse(invoice.created_at) == date
     end
   end

  def revenue(date = nil)
    all_invoices_by_date(date)

  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
