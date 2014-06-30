require 'csv'
require './lib/item'

class ItemRepository
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def self.load(file)
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Item.new(row)
    end
    new(rows)
  end

end
