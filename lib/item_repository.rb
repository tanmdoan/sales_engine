require 'csv'
require_relative 'item'


class ItemRepository
  attr_reader :items, :sales_engine

  def initialize(items)
    @items = items
  end

  def self.load(sales_engine, file ='./data/items.csv')
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
    merchant_id = merchant_id.to_s
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

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
