class Customer
  attr_reader :id, :first_name, :created_at, :updated_at

  def initialize(data)
    @id         = data[:id]
    @first_name = data[:first_name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end
end
