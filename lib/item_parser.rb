require './test/test_helper'


class ItemParser
  attr_reader :parse

  def initialize(parse)
    @parse = parse
  end

  def self.load(sales_engine, file='./data/items.csv')
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Item.new(row)
    end
    sales_engine.item_repository = ItemRepository.new(rows, sales_engine)
  end
end
