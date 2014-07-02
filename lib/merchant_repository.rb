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
    merchants.select do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    name = name.to_s
    selected = []
    merchants.detect do |merchant|
      selected << merchant if merchant.name == name
    end
    selected
  end

  def find_all_by_name(name)
    name = name.to_s
    merchants.select do |merchant|
      merchant.name == name
    end
  end

  def random
    selected = []
    selected << merchants.sample
    selected
  end

end
