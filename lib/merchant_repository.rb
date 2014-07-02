require './test/test_helper'
require 'pry'

class MerchantRepository
  attr_reader :merchants

  def initialize(merchants)
    @merchants = merchants
  end

  def self.load(file='./data/merchants.csv')
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Merchant.new(row)
    end
    new(rows)
  end

  def find_by_id(id)
    id = id.to_s
    results = merchants.select do |merchant|
      merchant.id == id
    end
    binding.pry
  end
end
