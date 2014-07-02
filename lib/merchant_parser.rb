require './test/test_helper'


class MerchantParser
    attr_reader :parse
  def initialize(parse)
    @parse = parse
  end

  def self.load(file='./data/merchants.csv')
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Merchant.new(row)
    end
    new(rows)
  end
end
