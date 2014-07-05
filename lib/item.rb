class Item
  attr_reader :id, :name, :description, :unit_price,
              :merchant_id, :created_at, :updated_at, :sales_engine

  def initialize(data, sales_engine)
    @id          = data[:id]
    @name        = data[:name]
    @description = data[:description]
    @unit_price  = data[:unit_price]
    @merchant_id = data[:merchant_id]
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @sales_engine = sales_engine
  end
end
