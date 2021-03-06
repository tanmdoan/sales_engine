require 'csv'
require_relative 'item'

class ItemRepository
  attr_reader :items, :sales_engine

  def initialize(items)
    @items = items
  end

  def self.load(sales_engine, file ='./data/customers.csv')
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Item.new(row, sales_engine)
    end
    new(rows)
  end

  def find_by_id(id)
    results = items.detect do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    items.detect do |item|
      item.name == name
    end
  end

  def find_all_by_name(name)
    items.select do |item|
      item.name == name
    end
  end

  def find_by_merchant_id(merchant_id)
    items.detect do |item|
      item.merchant_id == merchant_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    items.select do |item|
      item.merchant_id == merchant_id
    end
  end

  def find_by_unit_price(unit_price)
    items.detect do |item|
      item.unit_price == unit_price
    end
  end

  def find_all_by_unit_price(unit_price)
    items.select do |item|
      item.unit_price == unit_price
    end
  end

  def random
    items.sample
  end

  def all
    @items
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def most_revenue(number = nil)
    number ||= all.count
    all.sort_by(&:revenue).reverse[0...number]
  end

  def most_items(number)
    number ||= all.count
    all.sort_by(&:quantity).reverse[0...number]
  end

end
