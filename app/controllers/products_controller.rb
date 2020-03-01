class ProductsController < ApplicationController
  def index
    @products = Product.all

    render json: {"data": @products}, :except => [:created_at, :updated_at]
  end
end
