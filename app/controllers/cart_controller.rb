class CartController < ApplicationController
  wrap_parameters format: []
  before_action :set_cart

  def index
    render json: @cart.to_json
  end

  def create
    record = Record.new(record_params)
    if record.valid? && Product.all.map(& :id).include?(record.product_id)
      @cart.add_product(record)
      head :ok
    else
      errors = []
      record.errors.messages.each do |key, value|
        errors << {"code": "required", "message": value.join(", "), "name": key}
      end

      render json: {
        error: {
          params: errors,
          type: "invalid_param_error",
          message: "Invalid data parameters"
        }
      }, status: 400
    end
  end

  def destroy
    if Product.exists?(params[:product_id]) && @cart.contain_record?(params[:product_id])
      @cart.remove_product(params[:product_id])
      head :ok
    else
      render json: {
        error: {
          type: "invalid_param_error",
          message: "There is no such product in the system."
        }
      }, status: 400
    end
  end

  private

    def set_cart
      @cart = Cart.instance
    end

    def record_params
      params.permit(:product_id, :quantity)
    end
end
