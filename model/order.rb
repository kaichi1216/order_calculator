class Order
  attr_reader :product_list, :user_id, :original_price, :discount_price, :final_price, :discount_content

  def initialize(params = {})
    @product_list = params[:product_list]
    @user_id = params[:user_id]
    @original_price = params[:calculate][:original]
    @discount_price = params[:calculate][:discount]
    @final_price = params[:calculate][:final]
    @discount_content = params[:calculate][:discount_content]
  end

end