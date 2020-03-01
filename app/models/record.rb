class Record
  include ActiveModel::Model

  attr_accessor :product_id, :quantity, :sum

  validates :product_id, :quantity, presence: true
  validates :product_id, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }

  def initialize(attributes = {})
    @product_id = set_attribute(attributes[:product_id])
    @quantity = set_attribute(attributes[:quantity])
    calculate_sum
  end

  def check_product_id
    unless Product.exists?(:product_id)
      errors.add(:product_id, "Такого продукта нет в системе")
    end
  end

  def calculate_sum
    @sum = Product.find(product_id).price * quantity
  rescue
    0
  end

  def set_attribute(value)
    if value
      if value.scan(/\A\d+\z/).empty?
        value
      else
        value.to_i
      end
    end
  end

  def as_json(options = "empty")
    {
      id: product_id,
      quantity: quantity,
      sum: sum
    }
  end
end
