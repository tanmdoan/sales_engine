require 'csv'
require_relative 'merchant'

class MerchantRepository

  attr_reader :merchants, :sales_engine

  def initialize(merchants)
    @merchants ||= merchants
  end

  def self.load(sales_engine, file='./data/customers.csv')
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

  def all
    @merchants
  end

  def most_revenue(number = nil)
    number ||= all.count
    all.sort_by(&:revenue).reverse[0...number]
  end

  def most_items(number)
    number ||= all.count
    all.sort_by(&:quantity).reverse[0...number]
  end


  def random
    merchants.sample
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
