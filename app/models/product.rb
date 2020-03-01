class Product < ApplicationRecord
  validates :name, :description, presence: true
  validates :price, format: { with: /\A\d+\z/ }
end
