require './test/test_helper'
require 'pry'

class MerchantRepositoryParser
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
