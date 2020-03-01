class Cart
  include Singleton
  attr_accessor :records

  def initialize
    @records = []
  end

  def add_product(record)
    if existing_record = records.detect { |item| item.product_id == record.product_id }
      existing_record.quantity += record.quantity
      existing_record.calculate_sum
    else
      records << record
    end
  end

  def remove_product(product_id)
    found_record = records.select { |item| item.product_id == product_id.to_i }

    if found_record.last.quantity > 1
      found_record.last.quantity -= 1
      found_record.last.calculate_sum
    else
      records.delete_if { |item| item.product_id == product_id.to_i }
    end
  end

  def length
    records.length
  end

  def contain_record?(id)
    records.map(& :product_id).include?(id.to_i)
  end

  def as_json(options = "empty")
    {
      data: {
        total_sum: records.map { |p| p.sum }.reduce(0, :+),
        products_count: length,
        products: records
      }
    }
  end
end
