require './test/test_helper'


class ItemRepository
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def self.load(sales_engine, file ='./data/items.csv')
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Item.new(row)
    end
    new(rows)
  end

def find_by_id(id)
    id = id.to_s
    results = items.select do |item|
      item.id == id
    end
    binding.pry
  end

  def find_by_id(id)
    id = id.to_s
    items.select do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    name = name.to_s
    selected = []
    selected = items.detect do |item|
      selected << item if item.name == name
    end
    selected
  end

  def find_by_merchant_id(merchant_id)
    merchant_id = merchant_id.to_s
    selected = []
    items.detect do |item|
      selected << item if item.merchant_id == merchant_id
    end
    selected
  end

  def find_all_by_merchant_id(merchant_id)
    merchant_id = merchant_id.to_s
    items.select do |item|
      item.merchant_id == merchant_id
    end
  end


  def find_by_unit_price(unit_price)
    unit_price = unit_price.to_s
    selected = []
    items.detect do |item|
      selected << item if item.unit_price == unit_price
    end
    selected
  end

  def find_all_by_unit_price(unit_price)
    unit_price = unit_price.to_s
    items.select do |item|
      item.unit_price == unit_price
    end
  end

  def random
    selected = []
    selected << items.sample
    selected
  end

end
