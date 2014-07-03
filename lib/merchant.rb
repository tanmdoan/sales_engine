class Merchant
  attr_reader :id, :name, :created_at, :updated_at,
              :sales_engine

  def initialize(data, sales_engine)
    @id           = data[:id]
    @name         = data[:name]
    @created_at   = data[:created_at]
    @updated_at   = data[:updated_at]
    @sales_engine = sales_engine
  end

  def items
    sales_engine.item_repository.find_all_by_merchant_id(id)
  end
end
